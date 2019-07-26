pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2;

import {EIP1962} from "./EIP1962.sol";

contract ExampleCurve {

    bytes opDataG1;
    bytes opDataG2;
    bytes opDataPairing;
    EIP1962.CurveParams params;

    constructor() public {
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

        EIP1962.verifyCorrectCurveParamsLengths(params);

        opDataG1 = EIP1962.getG1OpDataInBytes(params);
        opDataG2 = EIP1962.getG2OpDataInBytes(params);
        opDataPairing = EIP1962.getPairingOpDataInBytes(params);
    }

    function g1Add(
        bytes memory lhs,
        bytes memory rhs
    ) public view returns (bytes memory result) {
        EIP1962.verifyCorrectG1AddDataLengths(params, lhs, rhs);
        result = EIP1962.g1Add(opDataG1, lhs, rhs);
    }

    function g1Mul(
        bytes memory lhs,
        bytes memory rhs
    ) public view returns (bytes memory result) {
        EIP1962.verifyCorrectG1MulDataLengths(params, lhs, rhs);
        result = EIP1962.g1Add(opDataG1, lhs, rhs);
    }

    function g1MultiExp(
        uint8 numPairs,
        bytes memory point,
        bytes memory scalar
    ) public view returns (bytes memory result) {
        EIP1962.verifyCorrectG1MultiExpDataLengths(params, point, scalar);
        result = EIP1962.g1MultiExp(opDataG1, numPairs, point, scalar);
    }

    function g2Add(
        bytes memory lhs,
        bytes memory rhs
    ) public view returns (bytes memory result) {
        EIP1962.verifyCorrectG2AddDataLengths(params, lhs, rhs);
        result = EIP1962.g2Add(opDataG2, lhs, rhs);
    }

    function g2Mul(
        bytes memory lhs,
        bytes memory rhs
    ) public view returns (bytes memory result) {
        EIP1962.verifyCorrectG2MulDataLengths(params, lhs, rhs);
        result = EIP1962.g2Mul(opDataG2, lhs, rhs);
    }

    function g2MultiExp(
        uint8 numPairs,
        bytes memory point,
        bytes memory scalar
    ) public view returns (bytes memory result) {
        EIP1962.verifyCorrectG2MultiExpDataLengths(params, point, scalar);
        result = EIP1962.g2MultiExp(opDataG2, numPairs, point, scalar);
    }

    function pairing(
        uint8 numPairs,
        bytes memory pairs
    ) public view returns (bytes memory result) {
        EIP1962.verifyCorrectPairingPairsLengths(params, numPairs, pairs);
        result = EIP1962.pairing(opDataPairing, numPairs, pairs);
    }

}