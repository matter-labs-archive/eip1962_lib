pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2;

import {EllipticCurve} from "../contracts/EllipticCurve.sol";
import {CommonTypes} from "../contracts/CommonTypes.sol";
import {HelpersForTests} from "../test/HelpersForTests.sol";

contract TestABI {

    EllipticCurve elCurve;

    constructor(CommonTypes.CurveParams memory curveParams) public {
        elCurve = new EllipticCurve(curveParams);
    }

    function getCurveParams() public view {
        elCurve.getCurveParams();
    }

    function changeCurveParams(CommonTypes.CurveParams memory curveParams) public {
        elCurve.changeCurveParams(curveParams);
    }

    function testAddG1(uint p1x, uint p1y,
                       uint p2x, uint p2y,
                       bytes memory correctResult) public view returns (bool) {
        CommonTypes.G1Point memory p1 = CommonTypes.G1Point({
            X: p1x,
            Y: p1y
        });
        CommonTypes.G1Point memory p2 = CommonTypes.G1Point({
            X: p2x,
            Y: p2y
        });
        bytes memory result = elCurve.g1Add(p1, p2);
        return HelpersForTests.equal(result, correctResult);
    }

    function testMulG1(uint px, uint py,
                       bytes memory factor,
                       bytes memory correctResult) public view returns (bool) {
        CommonTypes.G1Point memory p = CommonTypes.G1Point({
            X: px,
            Y: py
        });
        bytes memory result = elCurve.g1Mul(p, factor);
        return HelpersForTests.equal(result, correctResult);
    }

    function testMultiExpG1(uint8 numPairs,
                            uint px, uint py,
                            bytes memory order,
                            bytes memory correctResult) public view returns (bool) {
        CommonTypes.G1Point memory p = CommonTypes.G1Point({
            X: px,
            Y: py
        });
        bytes memory result = elCurve.g1MultiExp(numPairs, p, order);
        return HelpersForTests.equal(result, correctResult);
    }

    function testAddG2(uint p1x0, uint p1x1,
                       uint p1y0, uint p1y1,
                       uint p2x0, uint p2x1,
                       uint p2y0, uint p2y1,
                       bytes memory correctResult) public view returns (bool) {
        CommonTypes.G2Point memory p1 = CommonTypes.G2Point({
            X: [p1x0, p1x1],
            Y: [p1y0, p1y1]
        });
        CommonTypes.G2Point memory p2 = CommonTypes.G2Point({
            X: [p2x0, p2x1],
            Y: [p2y0, p2y1]
        });
        bytes memory result = elCurve.g2Add(p1, p2);
        return HelpersForTests.equal(result, correctResult);
    }

    function testMulG2(uint px0, uint px1,
                       uint py0, uint py1,
                       bytes memory factor,
                       bytes memory correctResult) public view returns (bool) {
        CommonTypes.G2Point memory p = CommonTypes.G2Point({
            X: [px0, px1],
            Y: [py0, py1]
        });
        bytes memory result = elCurve.g2Mul(p, factor);
        return HelpersForTests.equal(result, correctResult);
    }

    function testMultiExpG2(uint8 numPairs,
                            uint px0, uint px1,
                            uint py0, uint py1,
                            bytes memory order,
                            bytes memory correctResult) public view returns (bool) {
        CommonTypes.G2Point memory p = CommonTypes.G2Point({
            X: [px0, px1],
            Y: [py0, py1]
        });
        bytes memory result = elCurve.g2MultiExp(numPairs, p, order);
        return HelpersForTests.equal(result, correctResult);
    }

    function testPairing(uint[2] memory g1p1,
                         uint[4] memory g2p1,
                         uint[2] memory g1p2,
                         uint[4] memory g2p2,
                         bytes memory correctResult) public view returns (bool) {
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

        bytes memory result = elCurve.pairing(resPairs);
        return HelpersForTests.equal(result, correctResult);
    }

}