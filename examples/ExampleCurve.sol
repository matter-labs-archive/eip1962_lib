pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2;

import {EIP1962} from "../contracts/EIP1962.sol";

contract ExampleCurve {

    function g1Add(
        bytes memory lhs,
        bytes memory rhs
    ) public view returns (bytes memory result) {
        result = EIP1962.g1Add(EIP1962.exampleCurveParams(), lhs, rhs);
    }

    function g1Mul(
        bytes memory lhs,
        bytes memory rhs
    ) public view returns (bytes memory result) {
        result = EIP1962.g1Add(EIP1962.exampleCurveParams(), lhs, rhs);
    }

    function g1MultiExp(
        uint8 numPairs,
        bytes memory point,
        bytes memory scalar
    ) public view returns (bytes memory result) {
        result = EIP1962.g1MultiExp(EIP1962.exampleCurveParams(), numPairs, point, scalar);
    }

    function g2Add(
        bytes memory lhs,
        bytes memory rhs
    ) public view returns (bytes memory result) {
        result = EIP1962.g2Add(EIP1962.exampleCurveParams(), lhs, rhs);
    }

    function g2Mul(
        bytes memory lhs,
        bytes memory rhs
    ) public view returns (bytes memory result) {
        result = EIP1962.g2Mul(EIP1962.exampleCurveParams(), lhs, rhs);
    }

    function g2MultiExp(
        uint8 numPairs,
        bytes memory point,
        bytes memory scalar
    ) public view returns (bytes memory result) {
        result = EIP1962.g2MultiExp(EIP1962.exampleCurveParams(), numPairs, point, scalar);
    }

    function pairing(
        uint8 numPairs,
        bytes memory pairs
    ) public view returns (bytes memory result) {
        result = EIP1962.pairing(EIP1962.exampleCurveParams(), numPairs, pairs);
    }

}