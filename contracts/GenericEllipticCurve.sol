pragma solidity ^0.5.10;
pragma experimental ABIEncoderV2;

import {Bytes} from "../contracts/Bytes.sol";
import {CommonTypes} from "../contracts/CommonTypes.sol";

library GenericEllipticCurve {

    // MARK: - Supported operations with codes
    uint8 internal constant OPERATION_G1_ADD = 0x01;
    uint8 internal constant OPERATION_G1_MUL = 0x02;
    uint8 internal constant OPERATION_G1_MULTIEXP = 0x03;
    uint8 internal constant OPERATION_G2_ADD = 0x04;
    uint8 internal constant OPERATION_G2_MUL = 0x05;
    uint8 internal constant OPERATION_G2_MULTIEXP = 0x06;
    uint8 internal constant OPERATION_PAIRING = 0x07;

    //
    // MARK: - G1 operations
    //

    // Compies the common prefix for all G1 operations based on curve parameters.
    // Returns the newly created bytes memory.
    function getG1OpDataInBytes(CommonTypes.CurveParams memory curveParams) internal pure returns (bytes memory) {
        bytes memory opData = new bytes(2 + 3 * uint(curveParams.fieldLength) + uint(curveParams.groupOrderLength));
        opData = Bytes.toBytesFromUInt8(curveParams.fieldLength);
        opData = Bytes.concat(opData, curveParams.baseFieldModulus);
        opData = Bytes.concat(opData, curveParams.a);
        opData = Bytes.concat(opData, curveParams.b);
        opData = Bytes.concat(opData, Bytes.toBytesFromUInt8(curveParams.groupOrderLength));
        opData = Bytes.concat(opData, curveParams.groupOrder);
        return opData;
    }

    // Compies the G1 Add operation result.
    // Params:
    // - curveParams - curve parameters
    // - lhs - first point's X and Y coordinates in bytes
    // - rhs - second point's X and Y coordinates in bytes
    // Returns: operation input and outputLength
    function formG1AddInput(
        CommonTypes.CurveParams memory curveParams,
        bytes memory lhs,
        bytes memory rhs
    ) internal pure returns (bytes memory, uint) {

        // verifyCorrectG1AddDataLengths(curveParams, lhs, rhs);

        bytes memory opData = getG1OpDataInBytes(curveParams);

        bytes memory input = new bytes(1 + opData.length + lhs.length + rhs.length);
        input = Bytes.toBytesFromUInt8(OPERATION_G1_ADD);
        input = Bytes.concat(input, opData);
        input = Bytes.concat(input, lhs);
        input = Bytes.concat(input, rhs);

        return (input, 2*curveParams.fieldLength);
    }

    // Compies the G1 Mul operation result.
    // Params:
    // - curveParams - curve parameters
    // - lhs - first point's X and Y coordinates in bytes
    // - rhs - sсalar multiplication factor in bytes
    // Returns: operation input and outputLength
    function formG1MulInput(
        CommonTypes.CurveParams memory curveParams,
        bytes memory lhs,
        bytes memory rhs
    ) internal pure returns (bytes memory, uint) {

        // verifyCorrectG1MulDataLengths(curveParams, lhs, rhs);

        bytes memory opData = getG1OpDataInBytes(curveParams);

        bytes memory input = new bytes(1 + opData.length + lhs.length + rhs.length);
        input = Bytes.toBytesFromUInt8(OPERATION_G1_MUL);
        input = Bytes.concat(input, opData);
        input = Bytes.concat(input, lhs);
        input = Bytes.concat(input, rhs);

        return (input, 2*curveParams.fieldLength);
    }

    // Compies the G1 Multiexponentiation operation result.
    // Params:
    // - curveParams - curve parameters
    // - numPairs - number of (point, scalar) pairs for multiexponentiation
    // - pointScalarPairs - (point, scalar) pairs for multiexponentiation
    // Returns: operation input and outputLength
    function formG1MultiExpInput(
        CommonTypes.CurveParams memory curveParams,
        uint8 numPairs,
        bytes memory pointScalarPairs
    ) internal pure returns (bytes memory, uint) {

        // verifyCorrectG1MultiExpDataLengths(curveParams, point, scalar);

        bytes memory opData = getG1OpDataInBytes(curveParams);

        bytes memory input = new bytes(2 + opData.length + pointScalarPairs.length);
        input = Bytes.toBytesFromUInt8(OPERATION_G1_MULTIEXP);
        input = Bytes.concat(input, opData);
        input = Bytes.concat(input, Bytes.toBytesFromUInt8(numPairs));
        input = Bytes.concat(input, pointScalarPairs);

        return (input, 2*curveParams.fieldLength);
    }

    //
    // MARK: - G2 operations
    //

    // Compies the common prefix for all G2 operations based on curve parameters.
    // Returns the newly created bytes memory.
    function getG2OpDataInBytes(CommonTypes.CurveParams memory curveParams) internal pure returns (bytes memory) {
        bytes memory opData = new bytes(3 + 4 * uint(curveParams.fieldLength) + uint(curveParams.groupOrderLength));
        opData = Bytes.toBytesFromUInt8(curveParams.fieldLength);
        opData = Bytes.concat(opData, curveParams.baseFieldModulus);
        opData = Bytes.concat(opData, Bytes.toBytesFromUInt8(curveParams.extensionDegree));
        opData = Bytes.concat(opData, curveParams.fpNonResidue);
        opData = Bytes.concat(opData, curveParams.a);
        opData = Bytes.concat(opData, curveParams.b);
        opData = Bytes.concat(opData, Bytes.toBytesFromUInt8(curveParams.groupOrderLength));
        opData = Bytes.concat(opData, curveParams.groupOrder);
        return opData;
    }

    // Compies the G2 Add operation result.
    // Params:
    // - curveParams - curve parameters
    // - lhs - first point's X and Y coordinates in bytes
    // - rhs - second point's X and Y coordinates in bytes
    // Returns: operation input and outputLength
    function formG2AddInput(
        CommonTypes.CurveParams memory curveParams,
        bytes memory lhs,
        bytes memory rhs
    ) internal pure returns (bytes memory, uint) {

        // verifyCorrectG2AddDataLengths(curveParams, lhs, rhs);

        bytes memory opData = getG2OpDataInBytes(curveParams);

        bytes memory input = new bytes(1 + opData.length + lhs.length + rhs.length);
        input = Bytes.toBytesFromUInt8(OPERATION_G2_ADD);
        input = Bytes.concat(input, opData);
        input = Bytes.concat(input, lhs);
        input = Bytes.concat(input, rhs);

        return (input, 2*curveParams.extensionDegree*curveParams.fieldLength);
    }

    // Compies the G2 Mul operation result.
    // Params:
    // - curveParams - curve parameters
    // - lhs - first point's X and Y coordinates in bytes
    // - rhs - sсalar multiplication factor in bytes
    // Returns: operation input and outputLength.
    function formG2MulInput(
        CommonTypes.CurveParams memory curveParams,
        bytes memory lhs,
        bytes memory rhs
    ) internal pure returns (bytes memory, uint) {

        // verifyCorrectG2MulDataLengths(curveParams, lhs, rhs);

        bytes memory opData = getG2OpDataInBytes(curveParams);

        bytes memory input = new bytes(1 + opData.length + lhs.length + rhs.length);
        input = Bytes.toBytesFromUInt8(OPERATION_G2_MUL);
        input = Bytes.concat(input, opData);
        input = Bytes.concat(input, lhs);
        input = Bytes.concat(input, rhs);

        return (input, 2*curveParams.extensionDegree*curveParams.fieldLength);
    }

    // Compies the G2 Multiexponentiation operation result.
    // Params:
    // - curveParams - curve parameters
    // - numPairs - number of (point, scalar) pairs for multiexponentiation
    // - pointScalarPairs - (point, scalar) pairs for multiexponentiation
    // Returns: operation input and outputLength.
    function formG2MultiExpInput(
        CommonTypes.CurveParams memory curveParams,
        uint8 numPairs,
        bytes memory pointScalarPairs
    ) internal pure returns (bytes memory, uint) {

        // verifyCorrectG2MultiExpDataLengths(curveParams, point, scalar);

        bytes memory opData = getG2OpDataInBytes(curveParams);

        bytes memory input = new bytes(2 + opData.length + pointScalarPairs.length);
        input = Bytes.toBytesFromUInt8(OPERATION_G2_MULTIEXP);
        input = Bytes.concat(input, opData);
        input = Bytes.concat(input, Bytes.toBytesFromUInt8(numPairs));
        input = Bytes.concat(input, pointScalarPairs);

        return (input, 2*curveParams.extensionDegree*curveParams.fieldLength);
    }

    // MARK: - Pairing operation

    // Compies the common prefix for pairing operation based on curve parameters.
    // Returns the newly created bytes memory.
    function getPairingOpDataInBytes(CommonTypes.CurveParams memory curveParams) internal pure returns (bytes memory) {
        bytes memory opData = new bytes(6 + 6 * uint(curveParams.fieldLength) + uint(curveParams.groupOrderLength) + uint(curveParams.xLength));
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
        return opData;
    }

    // Compies the pairing operation input and outputLength.
    // Params:
    // - curveParams - curve parameters
    // - pairs - point pairs encoded as (G1 point, G2 point) in CommonTypes.Pair struct representation
    // Returns: pairing input and outputLength
    function formPairingInput(
        CommonTypes.CurveParams memory curveParams,
        bytes memory pairs,
        uint8 numPairs
    ) internal pure returns (bytes memory, uint) {

        // verifyCorrectPairingPairsLengths(curveParams, pairsBytes, numPairs);

        bytes memory opData = getPairingOpDataInBytes(curveParams);

        bytes memory input = new bytes(2 + opData.length + pairs.length);
        input = Bytes.toBytesFromUInt8(OPERATION_PAIRING);
        input = Bytes.concat(input, opData);
        input = Bytes.concat(input, Bytes.toBytesFromUInt8(numPairs));
        input = Bytes.concat(input, pairs);

        return (input, 1);
    }

    // Compies the EIP-1962 contract static call result.
    // Params:
    // - input - operation input in bytes representation
    // - inputLength - operation input's bytes length
    // - outLength - operation output's bytes length
    // Returns: if result of a pairing (element of Fp12) is equal to identity
    //  - return single byte 0x01, otherwise return 0x00 following the existing ABI for BN254 precompile.
    function callEip1962(
        uint contractId,
        bytes memory input,
        uint inputLength,
        uint outputLength
    ) internal view returns (bytes memory output) {
        assembly {
            if iszero(staticcall(gas, contractId, add(input, 0x20), inputLength, add(output, 0x20), outputLength)) {
               invalid()
            }
        }
    }
}
