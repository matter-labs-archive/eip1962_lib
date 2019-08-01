pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2;

import {Bytes} from "../contracts/Bytes.sol";
import {CommonTypes} from "../contracts/CommonTypes.sol";

library LengthsVerifier {
    // Verifies the correctness of the curve parameters.
    function verifyCorrectCurveParamsLengths(CommonTypes.CurveParams memory params) private pure {
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
    ) private pure {
        verifyCorrectCurveParamsLengths(curveParams);
        require(lhs.length == 2 * curveParams.fieldLength, "lhs should be equal to 2*fieldLength");
        require(rhs.length == 2 * curveParams.fieldLength, "rhs should be equal to 2*fieldLength");
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
    ) private pure {
        verifyCorrectCurveParamsLengths(curveParams);
        require(lhs.length == 2 * curveParams.fieldLength, "lhs should be equal to 2*fieldLength");
        require(rhs.length == curveParams.groupOrderLength, "rhs should be equal to groupOrderLength");
    }

    // Verifies the correctness of the g1 multi exp operation parameters.
    // Params:
    // - curveParams - curve parameters
    // - point -  point's X and Y coordinates in bytes
    // - scalar - sсalar order of exponentiation in bytes
    function verifyCorrectG1MultiExpDataLengths(
        CommonTypes.CurveParams memory curveParams,
        bytes memory point,
        bytes memory scalar
    ) private pure {
        verifyCorrectCurveParamsLengths(curveParams);
        require(point.length == 2 * curveParams.fieldLength, "point should be equal to 2*fieldLength");
        require(scalar.length == curveParams.groupOrderLength, "scalar should be equal to groupOrderLength");
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
    ) private pure {
        verifyCorrectCurveParamsLengths(curveParams);
        require(
            lhs.length == 2 * curveParams.extensionDegree * curveParams.fieldLength,
            "lhs should be equal to extensionDegree * fieldLength"
        );
        require(
            rhs.length == 2 * curveParams.extensionDegree * curveParams.fieldLength,
            "rhs should be equal to extensionDegree * fieldLength"
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
    ) private pure {
        verifyCorrectCurveParamsLengths(curveParams);
        require(
            lhs.length == 2 * curveParams.extensionDegree * curveParams.fieldLength,
            "lhs should be equal to extensionDegree * fieldLength"
        );
        require(
            rhs.length == 2 * curveParams.groupOrderLength,
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
        bytes memory point,
        bytes memory scalar
    ) private pure {
        verifyCorrectCurveParamsLengths(curveParams);
        require(
            point.length == 2 * curveParams.extensionDegree * curveParams.fieldLength,
            "lhs should be equal to extensionDegree * fieldLength"
        );
        require(
            scalar.length == 2 * curveParams.groupOrderLength,
            "rhs should be equal to groupOrderLength"
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
    ) private pure {
        verifyCorrectCurveParamsLengths(curveParams);
        require(
            pairs.length == 6 * curveParams.fieldLength * numPairs,
            "pairs should be equal to 6 * fieldLength * numPairs"
        );
    }
}