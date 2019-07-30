pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2;

import {EIP1962} from "../contracts/EIP1962.sol";
import {PrebuildCurves} from "../contracts/PrebuildCurves.sol";

contract EIP1962API {

    // Enum describes possible curves.
    // 'Custom' is user defined curve.
    // 'Undefined' curve is undefined;
    enum CurveTypes {
        Bn256,
        Bls12_381,
        Custom,
        Undefined
    }

    // Current curve parameters
    EIP1962.CurveParams curveParams;

    // Current curve
    CurveTypes curveType;

    // Constructor input is curve type.
    // If _curveType is Custom then curveType will be setted to Undefined.
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

    // Modifier checks that current curveType is not undefined.
    modifier curveIsDefined() {
        require(
            curveType != CurveTypes.Undefined,
            "Curve should be defined: choose from prebuild or add custom curveParams"
        );
        _;
    }

    // Sets up current curveType and curveParams.
    // If _curveType is Custom then curveType will be setted to Undefined.
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

    // Sets up current curveParams. Current curveType will be setted up to Custom.
    function setCurveParams(
        EIP1962.CurveParams memory _curveParams
    ) public {
        curveParams = _curveParams;
        curveType = CurveTypes.Custom;
    }

    // Compies the G1 Add operation result.
    // It won't be executed if curveType is Undefined.
    // Params:
    // - lhs - first point's X and Y coordinates in G1Point struct representation
    // - rhs - second point's X and Y coordinates in G1Point struct representation
    // Returns the newly created bytes memory.
    function g1Add(
        EIP1962.G1Point memory lhs,
        EIP1962.G1Point memory rhs
    ) public view curveIsDefined() returns (bytes memory result) {
        result = EIP1962.g1Add(curveParams, lhs, rhs);
    }

    // Compies the G1 Mul operation result.
    // It won't be executed if curveType is Undefined.
    // Params:
    // - lhs - first point's X and Y coordinates in G1Point struct representation
    // - rhs - sсalar multiplication factor in bytes
    // Returns the newly created bytes memory.
    function g1Mul(
        EIP1962.G1Point memory lhs,
        bytes memory rhs
    ) public view curveIsDefined() returns (bytes memory result) {
        result = EIP1962.g1Mul(curveParams, lhs, rhs);
    }

    // Compies the G1 Multiexponentiation operation result.
    // It won't be executed if curveType is Undefined.
    // Params:
    // - numPairs - number of (point, scalar) pairs for multiexponentiation
    // - point -  point's X and Y coordinates in G1Point struct representation
    // - scalar - sсalar order of exponentiation in bytes
    // Returns the newly created bytes memory.
    function g1MultiExp(
        uint8 numPairs,
        EIP1962.G1Point memory point,
        bytes memory scalar
    ) public view curveIsDefined() returns (bytes memory result) {
        result = EIP1962.g1MultiExp(curveParams, numPairs, point, scalar);
    }

    // Compies the G2 Add operation result.
    // It won't be executed if curveType is Undefined.
    // Params:
    // - lhs - first point's X and Y coordinates in G2Point struct representation
    // - rhs - second point's X and Y coordinates in G2Point struct representation
    // Returns the newly created bytes memory.
    function g2Add(
        EIP1962.G2Point memory lhs,
        EIP1962.G2Point memory rhs
    ) public view curveIsDefined() returns (bytes memory result) {
        result = EIP1962.g2Add(curveParams, lhs, rhs);
    }

    // Compies the G2 Mul operation result.
    // It won't be executed if curveType is Undefined.
    // Params:
    // - lhs - first point's X and Y coordinates in G2Point struct representation
    // - rhs - sсalar multiplication factor in bytes
    // Returns the newly created bytes memory.
    function g2Mul(
        EIP1962.G2Point memory lhs,
        bytes memory rhs
    ) public view curveIsDefined() returns (bytes memory result) {
        result = EIP1962.g2Mul(curveParams, lhs, rhs);
    }

    // Compies the G2 Multiexponentiation operation result.
    // It won't be executed if curveType is Undefined.
    // Params:
    // - numPairs - number of (point, scalar) pairs for multiexponentiation
    // - point -  point's X and Y coordinates in G2Point struct representation
    // - scalar - sсalar order of exponentiation in bytes
    // Returns the newly created bytes memory.
    function g2MultiExp(
        uint8 numPairs,
        EIP1962.G2Point memory point,
        bytes memory scalar
    ) public view curveIsDefined() returns (bytes memory result) {
        result = EIP1962.g2MultiExp(curveParams, numPairs, point, scalar);
    }

    // Verifies the correctness of the pairing operation parameters.
    // It won't be executed if curveType is Undefined.
    // Params:
    // - pairs -  point pairs array encoded as (G1 point, G2 point) in bytes
    function pairing(
        EIP1962.Pair[] memory pairs
    ) public view curveIsDefined() returns (bytes memory result) {
        result = EIP1962.pairing(curveParams, pairs);
    }

}