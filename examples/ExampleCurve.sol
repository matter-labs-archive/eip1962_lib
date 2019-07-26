pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2;

import {EIP1962} from "../contracts/EIP1962.sol";

contract ExampleCurve {

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
    }

    function g1Add(
        bytes memory lhs,
        bytes memory rhs
    ) public view returns (bytes memory result) {
        result = EIP1962.g1Add(params, lhs, rhs);
    }

    function g1Mul(
        bytes memory lhs,
        bytes memory rhs
    ) public view returns (bytes memory result) {
        result = EIP1962.g1Add(params, lhs, rhs);
    }

    function g1MultiExp(
        uint8 numPairs,
        bytes memory point,
        bytes memory scalar
    ) public view returns (bytes memory result) {
        result = EIP1962.g1MultiExp(params, numPairs, point, scalar);
    }

    function g2Add(
        bytes memory lhs,
        bytes memory rhs
    ) public view returns (bytes memory result) {
        result = EIP1962.g2Add(params, lhs, rhs);
    }

    function g2Mul(
        bytes memory lhs,
        bytes memory rhs
    ) public view returns (bytes memory result) {
        result = EIP1962.g2Mul(params, lhs, rhs);
    }

    function g2MultiExp(
        uint8 numPairs,
        bytes memory point,
        bytes memory scalar
    ) public view returns (bytes memory result) {
        result = EIP1962.g2MultiExp(params, numPairs, point, scalar);
    }

    function pairing(
        uint8 numPairs,
        bytes memory pairs
    ) public view returns (bytes memory result) {
        result = EIP1962.pairing(params, numPairs, pairs);
    }

}