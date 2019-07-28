pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2;

import {EIP1962} from "../contracts/EIP1962.sol";

library BLS12 {

    function g1Add(
        EIP1962.G1Point memory lhs,
        EIP1962.G1Point memory rhs
    ) public view returns (bytes memory result) {
        result = EIP1962.g1Add(EIP1962.bls12(), lhs, rhs);
    }

    function g1Mul(
        EIP1962.G1Point memory lhs,
        bytes memory rhs
    ) public view returns (bytes memory result) {
        result = EIP1962.g1Mul(EIP1962.bls12(), lhs, rhs);
    }

    function g1MultiExp(
        uint8 numPairs,
        EIP1962.G1Point memory point,
        bytes memory scalar
    ) public view returns (bytes memory result) {
        result = EIP1962.g1MultiExp(EIP1962.bls12(), numPairs, point, scalar);
    }

    function g2Add(
        EIP1962.G2Point memory lhs,
        EIP1962.G2Point memory rhs
    ) public view returns (bytes memory result) {
        result = EIP1962.g2Add(EIP1962.bls12(), lhs, rhs);
    }

    function g2Mul(
        EIP1962.G2Point memory lhs,
        bytes memory rhs
    ) public view returns (bytes memory result) {
        result = EIP1962.g2Mul(EIP1962.bls12(), lhs, rhs);
    }

    function g2MultiExp(
        uint8 numPairs,
        EIP1962.G2Point memory point,
        bytes memory scalar
    ) public view returns (bytes memory result) {
        result = EIP1962.g2MultiExp(EIP1962.bls12(), numPairs, point, scalar);
    }

    function pairing(
        EIP1962.Pair[] memory pairs
    ) public view returns (bytes memory result) {
        result = EIP1962.pairing(EIP1962.bls12(), pairs);
    }

}