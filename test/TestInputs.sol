pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2;

import {GenericEllipticCurve} from "../contracts/GenericEllipticCurve.sol";
import {CommonTypes} from "../contracts/CommonTypes.sol";
import {HelpersForTests} from "../test/HelpersForTests.sol";
import {PrebuildCurves} from "../contracts/PrebuildCurves.sol";

contract TestInputs {

    CommonTypes.CurveParams curveParams;

    constructor() public {
        curveParams = PrebuildCurves.bn256();
    }

    function testFormAddG1Input(
            uint p1x, uint p1y,
            uint p2x, uint p2y,
            bytes memory correctInput
    ) public view returns (bool) {
        CommonTypes.G1Point memory p1 = CommonTypes.G1Point({
            X: p1x,
            Y: p1y
        });
        CommonTypes.G1Point memory p2 = CommonTypes.G1Point({
            X: p2x,
            Y: p2y
        });
        (bytes memory input, uint _) = GenericEllipticCurve.formG1AddInput(curveParams, p1, p2);
        return HelpersForTests.equal(input, correctInput);
    }

    function testFormMulG1Input(
        uint px, uint py,
        bytes memory factor,
        bytes memory correctInput
    ) public view returns (bool) {
        CommonTypes.G1Point memory p = CommonTypes.G1Point({
            X: px,
            Y: py
        });
        (bytes memory input, uint _) = GenericEllipticCurve.formG1MulInput(curveParams, p, factor);
        return HelpersForTests.equal(input, correctInput);
    }

    function testFormMultiExpG1Input(
        uint8 numPairs,
        uint px, uint py,
        bytes memory order,
        bytes memory correctInput
    ) public view returns (bool) {
        CommonTypes.G1Point memory p = CommonTypes.G1Point({
            X: px,
            Y: py
        });
        (bytes memory input, uint _) = GenericEllipticCurve.formG1MultiExpInput(curveParams, numPairs, p, order);
        return HelpersForTests.equal(input, correctInput);
    }

    function testFormAddG2Input(
        uint p1x0, uint p1x1,
        uint p1y0, uint p1y1,
        uint p2x0, uint p2x1,
        uint p2y0, uint p2y1,
        bytes memory correctInput
    ) public view returns (bool) {
        CommonTypes.G2Point memory p1 = CommonTypes.G2Point({
            X: [p1x0, p1x1],
            Y: [p1y0, p1y1]
        });
        CommonTypes.G2Point memory p2 = CommonTypes.G2Point({
            X: [p2x0, p2x1],
            Y: [p2y0, p2y1]
        });
        (bytes memory input, uint _) = GenericEllipticCurve.formG2AddInput(curveParams, p1, p2);
        return HelpersForTests.equal(input, correctInput);
    }

    function testFormMulG2Input(
        uint px0, uint px1,
        uint py0, uint py1,
        bytes memory factor,
        bytes memory correctInput
    ) public view returns (bool) {
        CommonTypes.G2Point memory p = CommonTypes.G2Point({
            X: [px0, px1],
            Y: [py0, py1]
        });
        (bytes memory input, uint _) = GenericEllipticCurve.formG2MulInput(curveParams, p, factor);
        return HelpersForTests.equal(input, correctInput);
    }

    function testFormMultiExpG2Input(
        uint8 numPairs,
        uint px0, uint px1,
        uint py0, uint py1,
        bytes memory order,
        bytes memory correctInput
    ) public view returns (bool) {
        CommonTypes.G2Point memory p = CommonTypes.G2Point({
            X: [px0, px1],
            Y: [py0, py1]
        });
        (bytes memory input, uint _) = GenericEllipticCurve.formG2MultiExpInput(curveParams, numPairs, p, order);
        return HelpersForTests.equal(input, correctInput);
    }

    function testFormPairingInput(
        uint[2] memory g1p1,
        uint[4] memory g2p1,
        uint[2] memory g1p2,
        uint[4] memory g2p2,
        bytes memory correctInput
    ) public view returns (bool) {
        CommonTypes.Pair memory pair1 = CommonTypes.Pair({
            g1p: CommonTypes.G1Point({
                X: g1p1[0],
                Y: g1p1[1]
            }),
            g2p: CommonTypes.G2Point({
                X: [g2p1[0], g2p1[1]],
                Y: [g2p1[2], g2p1[3]]
            })
        });
        CommonTypes.Pair memory pair2 = CommonTypes.Pair({
            g1p: CommonTypes.G1Point({
                X: g1p2[0],
                Y: g1p2[1]
            }),
            g2p: CommonTypes.G2Point({
                X: [g2p2[0], g2p2[1]],
                Y: [g2p2[2], g2p2[3]]
            })
        });
        CommonTypes.Pair[] memory resPairs = new CommonTypes.Pair[](2);
        resPairs[0] = pair1;
        resPairs[1] = pair2;

        (bytes memory input, uint _) = GenericEllipticCurve.formPairingInput(curveParams, resPairs);
        return HelpersForTests.equal(input, correctInput);
    }

}