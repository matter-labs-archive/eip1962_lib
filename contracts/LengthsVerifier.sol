pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2;

import {Bytes} from "../contracts/Bytes.sol";
import {CommonTypes} from "../contracts/CommonTypes.sol";

library LengthsVerifier {
    // Verifies the correctness of the curve parameters.
    function verifyCorrectCurveParamsLengths(CommonTypes.CurveParams memory params) public pure {
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

    // Verifies the correctness of the g1 add operation parameters.
    // Params:
    // - curveParams - curve parameters
    // - lhs - first point's X and Y coordinates in bytes
    // - rhs - second point's X and Y coordinates in bytes
    function verifyCorrectG1AddDataLengths(
        CommonTypes.CurveParams memory curveParams,
        bytes memory lhs,
        bytes memory rhs
    ) public pure {
        require(uint(lhs.length) == 2 * (uint(curveParams.fieldLength)), "lhs should be equal to 2*fieldLength");
        require(uint(rhs.length) == 2 * (uint(curveParams.fieldLength)), "rhs should be equal to 2*fieldLength");
    }

    // Verifies the correctness of the g1 mul operation parameters.
    // Params:
    // - curveParams - curve parameters
    // - lhs - first point's X and Y coordinates in bytes
    // - rhs - sсalar multiplication factor in bytes
    function verifyCorrectG1MulDataLengths(
        CommonTypes.CurveParams memory curveParams,
        bytes memory lhs,
        bytes memory rhs
    ) public pure {
        require(uint(lhs.length) == 2 * uint(curveParams.fieldLength), "lhs should be equal to 2*fieldLength");
        require(uint(rhs.length) == uint(curveParams.groupOrderLength), "rhs should be equal to groupOrderLength");
    }

    // Verifies the correctness of the g1 multi exp operation parameters.
    // Params:
    // - curveParams - curve parameters
    // - point -  point's X and Y coordinates in bytes
    // - scalar - sсalar order of exponentiation in bytes
    function verifyCorrectG1MultiExpDataLengths(
        CommonTypes.CurveParams memory curveParams,
        uint8 numPairs,
        bytes memory pointScalarPairs
    ) public pure {
        require(
            uint(pointScalarPairs.length) == uint(numPairs) * (2 * uint(curveParams.fieldLength) + uint(curveParams.groupOrderLength)),
            "pairs length should be equal to numPairs*(2*fieldLength+groupOrderLength)"
        );
    }

    // Verifies the correctness of the g2 add operation parameters.
    // Params:
    // - curveParams - curve parameters
    // - lhs - first point's X and Y coordinates in bytes
    // - rhs - second point's X and Y coordinates in bytes
    function verifyCorrectG2AddDataLengths(
        CommonTypes.CurveParams memory curveParams,
        bytes memory lhs,
        bytes memory rhs
    ) public pure {
        require(
            uint(lhs.length) == 2 * uint(curveParams.extensionDegree) * uint(curveParams.fieldLength),
            "lhs should be equal to 2 * extensionDegree * fieldLength"
        );
        require(
            uint(rhs.length) == 2 * uint(curveParams.extensionDegree) * uint(curveParams.fieldLength),
            "rhs should be equal to 2 * extensionDegree * fieldLength"
        );
    }

    // Verifies the correctness of the g2 mul operation parameters.
    // Params:
    // - curveParams - curve parameters
    // - lhs - first point's X and Y coordinates in bytes
    // - rhs - sсalar multiplication factor in bytes
    function verifyCorrectG2MulDataLengths(
        CommonTypes.CurveParams memory curveParams,
        bytes memory lhs,
        bytes memory rhs
    ) public pure {
        require(
            uint(lhs.length) == 2 * uint(curveParams.extensionDegree) * uint(curveParams.fieldLength),
            "lhs should be equal to 2 * extensionDegree * fieldLength"
        );
        require(
            uint(rhs.length) == 2 * uint(curveParams.groupOrderLength),
            "rhs should be equal to groupOrderLength"
        );
    }

    // Verifies the correctness of the g2 multi exp operation parameters.
    // Params:
    // - curveParams - curve parameters
    // - point -  point's X and Y coordinates in bytes
    // - scalar - sсalar order of exponentiation in bytes
    function verifyCorrectG2MultiExpDataLengths(
        CommonTypes.CurveParams memory curveParams,
        uint8 numPairs,
        bytes memory pointScalarPairs
    ) public pure {
        require(
            uint(pointScalarPairs.length) == uint(numPairs) * (2 * uint(curveParams.extensionDegree) * uint(curveParams.fieldLength) + uint(curveParams.groupOrderLength)),
            "pairs length should be equal to numPairs*(2*extensionDegree*fieldLength+groupOrderLength)"
        );
    }

    // Verifies the correctness of the pairing operation parameters.
    // Params:
    // - curveParams - curve parameters
    // - pairs -  point pairs array encoded as (G1 point, G2 point) in bytes
    function verifyCorrectPairingPairsLengths(
        CommonTypes.CurveParams memory curveParams,
        bytes memory pairs,
        uint8 numPairs
    ) public pure {
        require(
            uint(pairs.length) == 6 * uint(curveParams.fieldLength) * uint(numPairs),
            "pairs should be equal to 6 * fieldLength * numPairs"
        );
    }
}