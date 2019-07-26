pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2;

import {Bytes} from "../contracts/Bytes.sol";
import {Pairing} from "../contracts/Pairing.sol";

library EIP1962 {

    // using Bytes for bytes;

    // MARK: - Operations

    uint8 internal constant OPERATION_G1_ADD = 0x01;
    uint8 internal constant OPERATION_G1_MUL = 0x02;
    uint8 internal constant OPERATION_G1_MULTIEXP = 0x03;
    uint8 internal constant OPERATION_G2_ADD = 0x04;
    uint8 internal constant OPERATION_G2_MUL = 0x05;
    uint8 internal constant OPERATION_G2_MULTIEXP = 0x06;
    uint8 internal constant OPERATION_PAIRING = 0x07;

    // TODO: - ?
    uint8 internal constant CONTRACT_ID = 0x06;

    // Curve Params struct

    struct CurveParams {
        uint8 curveType;
        uint8 fieldLength;
        bytes baseFieldModulus;
        uint8 extensionDegree;
        bytes a;
        bytes b;
        uint8 groupOrderLength;
        bytes groupOrder;
        bytes fpNonResidue;
        bytes mainSubgroupOrder;
        bytes fp2NonResidue;
        bytes fp6NonResidue;
        uint8 twistType;
        uint8 xLength;
        bytes x;
        uint8 sign;
    }

    struct Pair {
        Pairing.G1Point p1;
        Pairing.G1Point p2;
    }

    // Curves list

    // TODO: - parameters are not correct
    function bls12() public pure returns (CurveParams memory params) {
        params = EIP1962.CurveParams({
            curveType: 0x01,
            fieldLength: 0x01,
            baseFieldModulus: "0x01",
            extensionDegree: 0x01,
            a: "0x01",
            b: "0x01",
            groupOrderLength: 0x01,
            groupOrder: "0x01",
            fpNonResidue: "0x01",
            mainSubgroupOrder: "0x01",
            fp2NonResidue: "0x01",
            fp6NonResidue: "0x01",
            twistType: 0x01,
            xLength: 0x01,
            x: "0x01",
            sign: 0x01
        });
    }
    
    // MARK: - Curve params lengths verifyCorrects

    function verifyCorrectCurveParamsLengths(CurveParams memory params) internal pure {
        require(params.baseFieldModulus.length == params.fieldLength, "baseFieldModulus should be equal to fieldLength");
        require(params.a.length == params.fieldLength, "a should be equal to fieldLength");
        require(params.b.length == params.fieldLength, "b should be equal to fieldLength");
        require(params.groupOrder.length == params.groupOrderLength, "groupOrder should be equal to groupOrderLength");
        require(params.baseFieldModulus.length == params.fieldLength, "baseFieldModulus should be equal to fieldLength");
        require(params.fpNonResidue.length == params.fieldLength, "fpNonResidue should be equal to fieldLength");
        require(params.mainSubgroupOrder.length == params.groupOrderLength, "mainSubgroupOrder should be equal to groupOrderLength");
        require(params.fp2NonResidue.length == params.fieldLength, "fp2NonResidue should be equal to fieldLength");
        require(params.fp6NonResidue.length == 2 * params.fieldLength, "fp6NonResidue should be equal to 2 * fieldLength");
        require(params.x.length == params.xLength, "x should be equal to xLength");
    }

    // MARK: - G1 data lengths verifyCorrects

    function verifyCorrectG1AddDataLengths(
        CurveParams memory curveParams,
        Pairing.G1Point memory lhs,
        Pairing.G1Point memory rhs
    ) internal pure {
        verifyCorrectCurveParamsLengths(curveParams);
        require(lhs.toBytes().length == 2 * curveParams.fieldLength, "lhs should be equal to 2*fieldLength");
        require(rhs.toBytes().length == 2 * curveParams.fieldLength, "rhs should be equal to 2*fieldLength");
    }

    function verifyCorrectG1MulDataLengths(
        CurveParams memory curveParams,
        Pairing.G1Point memory lhs,
        bytes memory rhs
    ) internal pure {
        verifyCorrectCurveParamsLengths(curveParams);
        require(lhs.toBytes().length == 2 * curveParams.fieldLength, "lhs should be equal to 2*fieldLength");
        require(rhs.length == curveParams.groupOrderLength, "rhs should be equal to groupOrderLength");
    }

    function verifyCorrectG1MultiExpDataLengths(
        CurveParams memory curveParams,
        Pairing.G1Point memory point,
        bytes memory scalar
    ) internal pure {
        verifyCorrectCurveParamsLengths(curveParams);
        require(point.toBytes().length == 2 * curveParams.fieldLength, "point should be equal to 2*fieldLength");
        require(scalar.length == curveParams.groupOrderLength, "scalar should be equal to groupOrderLength");
    }

    // MARK: - G1 opdata forming

    function getG1OpDataInBytes(CurveParams memory curveParams) internal pure returns (bytes memory opData) {
        opData = Bytes.toBytesFromUInt8(curveParams.fieldLength);
        opData = Bytes.concat(opData, curveParams.baseFieldModulus);
        opData = Bytes.concat(opData, curveParams.a);
        opData = Bytes.concat(opData, curveParams.b);
        opData = Bytes.concat(opData, Bytes.toBytesFromUInt8(curveParams.groupOrderLength));
        opData = Bytes.concat(opData, curveParams.groupOrder);
    }

    // MARK: - G1 operations

    function g1Add(
        CurveParams memory curveParams,
        Pairing.G1Point memory lhs,
        Pairing.G1Point memory rhs
    ) public view returns (bytes memory result) {
        verifyCorrectG1AddDataLengths(curveParams, lhs, rhs);
        bytes memory data;
        bytes memory lhsBytes = lhs.toBytes();
        bytes memory rhsBytes = lhs.toBytes();
        bytes memory opData = getG1OpDataInBytes(curveParams);
        data = Bytes.toBytesFromUInt8(OPERATION_G1_ADD);
        data = Bytes.concat(data, opData);
        data = Bytes.concat(data, lhsBytes);
        data = Bytes.concat(data, rhsBytes);
        result = callEip1962(
            data,
            1 + opData.length + lhsBytes.length + rhsBytes.length,
            lhsBytes.length
        );
    }

    function g1Mul(
        CurveParams memory curveParams,
        Pairing.G1Point memory lhs,
        bytes memory rhs
    ) public view returns (bytes memory result) {
        verifyCorrectG1MulDataLengths(curveParams, lhs, rhs);
        bytes memory data;
        bytes memory lhsBytes = lhs.toBytes();
        bytes memory opData = getG1OpDataInBytes(curveParams);
        data = Bytes.toBytesFromUInt8(OPERATION_G1_MUL);
        data = Bytes.concat(data, opData);
        data = Bytes.concat(data, lhsBytes);
        data = Bytes.concat(data, rhs);
        result = callEip1962(
            data,
            1 + opData.length + lhsBytes.length + rhs.length,
            lhsBytes.length
        );
    }

    function g1MultiExp(
        CurveParams memory curveParams,
        uint8 numPairs,
        Pairing.G1Point memory point,
        bytes memory scalar
    ) public view returns (bytes memory result) {
        verifyCorrectG1MultiExpDataLengths(curveParams, point, scalar);
        bytes memory data;
        bytes memory pointBytes = point.toBytes();
        bytes memory opData = getG1OpDataInBytes(curveParams);
        data = Bytes.toBytesFromUInt8(OPERATION_G1_MULTIEXP);
        data = Bytes.concat(data, opData);
        data = Bytes.concat(data, Bytes.toBytesFromUInt8(numPairs));
        data = Bytes.concat(data, pointBytes);
        data = Bytes.concat(data, scalar);
        result = callEip1962(
            data,
            2 + opData.length + pointBytes.length + scalar.length,
            pointBytes.length
        );
    }

    // MARK: - G2 data lengths verifyCorrects

    function verifyCorrectG2AddDataLengths(
        CurveParams memory curveParams,
        Pairing.G2Point memory lhs,
        Pairing.G2Point memory rhs
    ) internal pure {
        verifyCorrectCurveParamsLengths(curveParams);
        require(lhs.toBytes().length == curveParams.extensionDegree * curveParams.fieldLength, "lhs should be equal to extensionDegree * fieldLength");
        require(rhs.toBytes().length == curveParams.extensionDegree * curveParams.fieldLength, "rhs should be equal to extensionDegree * fieldLength");
    }

    function verifyCorrectG2MulDataLengths(
        CurveParams memory curveParams,
        Pairing.G2Point memory lhs,
        bytes memory rhs
    ) internal pure {
        verifyCorrectCurveParamsLengths(curveParams);
        require(lhs.toBytes().length == curveParams.extensionDegree * curveParams.fieldLength, "lhs should be equal to extensionDegree * fieldLength");
        require(rhs.length == curveParams.groupOrderLength, "rhs should be equal to groupOrderLength");
    }

    function verifyCorrectG2MultiExpDataLengths(
        CurveParams memory curveParams,
        Pairing.G2Point memory point,
        bytes memory scalar
    ) internal pure {
        verifyCorrectCurveParamsLengths(curveParams);
        require(point.toBytes().length == curveParams.extensionDegree * curveParams.fieldLength, "lhs should be equal to extensionDegree * fieldLength");
        require(scalar.length == curveParams.groupOrderLength, "rhs should be equal to groupOrderLength");
    }

    // MARK: - G2 opdata forming

    function getG2OpDataInBytes(CurveParams memory curveParams) internal pure returns (bytes memory opData) {
        opData = Bytes.toBytesFromUInt8(curveParams.fieldLength);
        opData = Bytes.concat(opData, curveParams.baseFieldModulus);
        opData = Bytes.concat(opData, Bytes.toBytesFromUInt8(curveParams.extensionDegree));
        opData = Bytes.concat(opData, curveParams.fpNonResidue);
        opData = Bytes.concat(opData, curveParams.a);
        opData = Bytes.concat(opData, curveParams.b);
        opData = Bytes.concat(opData, Bytes.toBytesFromUInt8(curveParams.groupOrderLength));
        opData = Bytes.concat(opData, curveParams.groupOrder);
    }

    // MARK: - G2 operations

    function g2Add(
        CurveParams memory curveParams,
        Pairing.G2Point memory lhs,
        Pairing.G2Point memory rhs
    ) public view returns (bytes memory result) {
        verifyCorrectG2AddDataLengths(curveParams, lhs, rhs);
        bytes memory data;
        bytes memory lhsBytes = lhs.toBytes();
        bytes memory rhsBytes = lhs.toBytes();
        bytes memory opData = getG2OpDataInBytes(curveParams);
        data = Bytes.toBytesFromUInt8(OPERATION_G2_ADD);
        data = Bytes.concat(data, opData);
        data = Bytes.concat(data, lhsBytes);
        data = Bytes.concat(data, rhsBytes);
        result = callEip1962(
            data,
            1 + opData.length + lhsBytes.length + rhsBytes.length,
            lhsBytes.length
        );
    }

    function g2Mul(
        CurveParams memory curveParams,
        Pairing.G1Point memory lhs,
        bytes memory rhs
    ) public view returns (bytes memory result) {
        verifyCorrectG2MulDataLengths(curveParams, lhs, rhs);
        bytes memory data;
        bytes memory lhsBytes = lhs.toBytes();
        bytes memory opData = getG2OpDataInBytes(curveParams);
        data = Bytes.toBytesFromUInt8(OPERATION_G2_MUL);
        data = Bytes.concat(data, opData);
        data = Bytes.concat(data, lhsBytes);
        data = Bytes.concat(data, rhs);
        result = callEip1962(
            data,
            1 + opData.length + lhsBytes.length + rhs.length,
            lhsBytes.length
        );
    }

    function g2MultiExp(
        CurveParams memory curveParams,
        uint8 numPairs,
        Pairing.G2Point memory point,
        bytes memory scalar
    ) public view returns (bytes memory result) {
        verifyCorrectG2MultiExpDataLengths(curveParams, point, scalar);
        bytes memory data;
        bytes memory pointBytes = point.toBytes();
        bytes memory opData = getG2OpDataInBytes(curveParams);
        data = Bytes.toBytesFromUInt8(OPERATION_G2_MULTIEXP);
        data = Bytes.concat(data, opData);
        data = Bytes.concat(data, Bytes.toBytesFromUInt8(numPairs));
        data = Bytes.concat(data, pointBytes);
        data = Bytes.concat(data, scalar);
        result = callEip1962(
            data,
            2 + opData.length + pointBytes.length + scalar.length,
            pointBytes.length
        );
    }

    // MARK: - Pairing data lengths verifyCorrects

    function verifyCorrectPairingPairsLengths(
        CurveParams memory curveParams,
        uint8 numPairs,
        Pair[] memory pairs
    ) internal pure {
        verifyCorrectCurveParamsLengths(curveParams);
        require(pairs.toBytes().length == 6 * curveParams.fieldLength * numPairs, "pairs should be equal to 6 * fieldLength * numPairs");
    }

    // MARK: - G2 opdata forming

    function getPairingOpDataInBytes(CurveParams memory curveParams) internal pure returns (bytes memory opData) {
        opData = Bytes.toBytesFromUInt8(curveParams.curveType);
        opData = Bytes.concat(opData, Bytes.toBytesFromUInt8(curveParams.fieldLength));
        opData = Bytes.concat(opData, curveParams.baseFieldModulus);
        opData = Bytes.concat(opData, curveParams.a);
        opData = Bytes.concat(opData, curveParams.b);
        opData = Bytes.concat(opData, Bytes.toBytesFromUInt8(curveParams.groupOrderLength));
        opData = Bytes.concat(opData, curveParams.mainSubgroupOrder);
        opData = Bytes.concat(opData, curveParams.fp2NonResidue);
        opData = Bytes.concat(opData, curveParams.fp6NonResidue);
        opData = Bytes.concat(opData, Bytes.toBytesFromUInt8(curveParams.twistType));
        opData = Bytes.concat(opData, Bytes.toBytesFromUInt8(curveParams.xLength));
        opData = Bytes.concat(opData, curveParams.x);
        opData = Bytes.concat(opData, Bytes.toBytesFromUInt8(curveParams.sign));
    }

    // MARK: - Pairing operations

    function pairing(
        CurveParams memory curveParams,
        uint8 numPairs,
        Pair[] memory pairs
    ) public view returns (bytes memory result) {
        verifyCorrectPairingPairsLengths(curveParams, numPairs, pairs);
        bytes memory data;
        bytes memory opData = getPairingOpDataInBytes(curveParams);
        data = Bytes.toBytesFromUInt8(OPERATION_PAIRING);
        data = Bytes.concat(data, opData);
        data = Bytes.concat(data, Bytes.toBytesFromUInt8(numPairs));
        data = Bytes.concat(data, pairs.toBytes());
        result = callEip1962(
            data,
            2 + opData.length + pairs.length,
            1
        );
    }

    // MARK: - EIP-1962 contract static call

    function callEip1962(
        bytes memory input,
        uint inputLength,
        uint outLength
    ) internal view returns (bytes memory result) {
        uint8 id = CONTRACT_ID;
        bytes memory out;
        assembly {
            result := staticcall(sub(gas, 2000), id, input, inputLength, out, outLength)
        }
    }
}
