pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2;

import {EIP1962} from "../contracts/EIP1962.sol";
import {PrebuildCurves} from "../contracts/PrebuildCurves.sol";

contract EIP1962API {

    enum CurveTypes {
        Bn256,
        Bls12_381,
        Custom,
        Undefined
    }

    EIP1962.CurveParams curveParams;
    CurveTypes curveType;

    constructor(CurveTypes _curveType) public {
        if (_curveType == CurveTypes.Custom) {
            curveParams = PrebuildCurves.undefined();
            _curveType = CurveTypes.Undefined;
        }
        curveType = _curveType;
        if (_curveType == CurveTypes.Bn256) {
            curveParams = PrebuildCurves.bn256();
        }
        if (_curveType == CurveTypes.Bls12_381) {
            curveParams = PrebuildCurves.bls12_381();
        }
        if (_curveType == CurveTypes.Undefined) {
            curveParams = PrebuildCurves.undefined();
        }
    }

    modifier curveIsDefined() {
        require(
            curveType != CurveTypes.Undefined,
            "Curve should be defined: choose from prebuild or add custom curveParams"
        );
        _;
    }

    function setCurveType(
        CurveTypes _curveType
    ) public {
        if (_curveType == CurveTypes.Custom) {
            curveParams = PrebuildCurves.undefined();
            _curveType = CurveTypes.Undefined;
        }
        curveType = _curveType;
        if (_curveType == CurveTypes.Bn256) {
            curveParams = PrebuildCurves.bn256();
        }
        if (_curveType == CurveTypes.Bls12_381) {
            curveParams = PrebuildCurves.bls12_381();
        }
        if (_curveType == CurveTypes.Undefined) {
            curveParams = PrebuildCurves.undefined();
        }
    }

    function setCurveParams(
        EIP1962.CurveParams memory _curveParams
    ) public {
        curveParams = _curveParams;
        curveType = CurveTypes.Custom;
    }

    function g1Add(
        EIP1962.G1Point memory lhs,
        EIP1962.G1Point memory rhs
    ) public view curveIsDefined() returns (bytes memory result) {
        result = EIP1962.g1Add(curveParams, lhs, rhs);
    }

    function g1Mul(
        EIP1962.G1Point memory lhs,
        bytes memory rhs
    ) public view curveIsDefined() returns (bytes memory result) {
        result = EIP1962.g1Mul(curveParams, lhs, rhs);
    }

    function g1MultiExp(
        uint8 numPairs,
        EIP1962.G1Point memory point,
        bytes memory scalar
    ) public view curveIsDefined() returns (bytes memory result) {
        result = EIP1962.g1MultiExp(curveParams, numPairs, point, scalar);
    }

    function g2Add(
        EIP1962.G2Point memory lhs,
        EIP1962.G2Point memory rhs
    ) public view curveIsDefined() returns (bytes memory result) {
        result = EIP1962.g2Add(curveParams, lhs, rhs);
    }

    function g2Mul(
        EIP1962.G2Point memory lhs,
        bytes memory rhs
    ) public view curveIsDefined() returns (bytes memory result) {
        result = EIP1962.g2Mul(curveParams, lhs, rhs);
    }

    function g2MultiExp(
        uint8 numPairs,
        EIP1962.G2Point memory point,
        bytes memory scalar
    ) public view curveIsDefined() returns (bytes memory result) {
        result = EIP1962.g2MultiExp(curveParams, numPairs, point, scalar);
    }

    function pairing(
        EIP1962.Pair[] memory pairs
    ) public view curveIsDefined() returns (bytes memory result) {
        result = EIP1962.pairing(curveParams, pairs);
    }

}