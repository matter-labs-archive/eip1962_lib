pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2;

import {GenericEllipticCurve} from "../contracts/GenericEllipticCurve.sol";
import {CommonTypes} from "../contracts/CommonTypes.sol";
import {HelpersForTests} from "../test/HelpersForTests.sol";
import {PrebuildCurves} from "../contracts/PrebuildCurves.sol";
import {LengthsVerifier} from "../contracts/LengthsVerifier.sol";

contract TestInputs {

    CommonTypes.CurveParams bls12_384_mul_params;

    constructor() public {
        bls12_384_mul_params = PrebuildCurves.bls12_384_m();
    }

    function testCurveParamsLengthsBLS12_384_M() public view returns (bool) {
        LengthsVerifier.verifyCorrectCurveParamsLengths(bls12_384_mul_params);
        return true;
    }

    function testG1OpDataBLS12_384_M() public view returns (bool) {
        bytes memory opData = GenericEllipticCurve.getG1OpDataInBytes(bls12_384_mul_params);
        bytes memory correctOpData = hex"31026d331f7ce9cdc5e48d73aeedf0a1d7f7870b788046ec2aff712eda78d3fe42dfb8fe05c47ae860b05717583ae170045d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012103c192577dfb697d258e5f48f4c3f36bb518d0ea9b498ca3559dfb03a2c685a529";
        return HelpersForTests.equal(opData, correctOpData);
    }

    function testG2OpDataBLS12_384_M() public view returns (bool) {
        bytes memory opData = GenericEllipticCurve.getG2OpDataInBytes(bls12_384_mul_params);
        bytes memory correctOpData = hex"31026d331f7ce9cdc5e48d73aeedf0a1d7f7870b788046ec2aff712eda78d3fe42dfb8fe05c47ae860b05717583ae170045d02026d331f7ce9cdc5e48d73aeedf0a1d7f7870b788046ec2aff712eda78d3fe42dfb8fe05c47ae860b05717583ae170045b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012103c192577dfb697d258e5f48f4c3f36bb518d0ea9b498ca3559dfb03a2c685a529";
        return HelpersForTests.equal(opData, correctOpData);
    }

    function testPairingOpDataBLS12_384_M() public view returns (bool) {
        bytes memory opData = GenericEllipticCurve.getPairingOpDataInBytes(bls12_384_mul_params);
        bytes memory correctOpData = hex"0131026d331f7ce9cdc5e48d73aeedf0a1d7f7870b788046ec2aff712eda78d3fe42dfb8fe05c47ae860b05717583ae170045d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012103c192577dfb697d258e5f48f4c3f36bb518d0ea9b498ca3559dfb03a2c685a529026d331f7ce9cdc5e48d73aeedf0a1d7f7870b788046ec2aff712eda78d3fe42dfb8fe05c47ae860b05717583ae170045b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010109016463d0693ad8bbad00";
        return HelpersForTests.equal(opData, correctOpData);
    }

    function testAddG1InputLengthsBLS12_384_M() public view returns (bool) {
        bytes memory p1 = hex"00b1d9d7d4e19966f41ed390530d41eebaaa1c707c3fb44303ae58df3c9e9c0589b4692a397ecdc90103df90ba78fb4a1c01af3190c07b6494b12dba8aae83c6f5a61251f82bdddcf4a00d0e8277cab9a7febdbbdb3f961ba3a2b38b9ad7a6a3cf49";
        bytes memory p2 = hex"02479e227b1762e5a8322ab109842fc1e481440020137ef6cd6282796bad37b95877281633289033017183acf2472e2b6c01851c8aab7868d17dc6bf38ba905a19ab8bcf308f1b417e833fa548f6a33afb4b91488d829cf924caeab5c09ad4593663";
        LengthsVerifier.verifyCorrectG1AddDataLengths(bls12_384_mul_params, p1, p2);
        return true;
    }

    function testMulG1InputLengthsBLS12_384_M() public view returns (bool) {
        bytes memory p = hex"00b1d9d7d4e19966f41ed390530d41eebaaa1c707c3fb44303ae58df3c9e9c0589b4692a397ecdc90103df90ba78fb4a1c01af3190c07b6494b12dba8aae83c6f5a61251f82bdddcf4a00d0e8277cab9a7febdbbdb3f961ba3a2b38b9ad7a6a3cf49";
        bytes memory mul = hex"01a377718a6300d8dfa68b483f26b2d31c2501427bf56373224e9a7e9d15cabfc9";
        LengthsVerifier.verifyCorrectG1MulDataLengths(bls12_384_mul_params, p, mul);
        return true;
    }

    function testMultiExpG1InputLengthsBLS12_384_M() public view returns (bool) {
        uint8 numPairs = 3;
        bytes memory pairs = hex"00b1d9d7d4e19966f41ed390530d41eebaaa1c707c3fb44303ae58df3c9e9c0589b4692a397ecdc90103df90ba78fb4a1c01af3190c07b6494b12dba8aae83c6f5a61251f82bdddcf4a00d0e8277cab9a7febdbbdb3f961ba3a2b38b9ad7a6a3cf4901a377718a6300d8dfa68b483f26b2d31c2501427bf56373224e9a7e9d15cabfc900b1d9d7d4e19966f41ed390530d41eebaaa1c707c3fb44303ae58df3c9e9c0589b4692a397ecdc90103df90ba78fb4a1c01af3190c07b6494b12dba8aae83c6f5a61251f82bdddcf4a00d0e8277cab9a7febdbbdb3f961ba3a2b38b9ad7a6a3cf4901a377718a6300d8dfa68b483f26b2d31c2501427bf56373224e9a7e9d15cabfc900b1d9d7d4e19966f41ed390530d41eebaaa1c707c3fb44303ae58df3c9e9c0589b4692a397ecdc90103df90ba78fb4a1c01af3190c07b6494b12dba8aae83c6f5a61251f82bdddcf4a00d0e8277cab9a7febdbbdb3f961ba3a2b38b9ad7a6a3cf4901a377718a6300d8dfa68b483f26b2d31c2501427bf56373224e9a7e9d15cabfc9";
        LengthsVerifier.verifyCorrectG1MultiExpDataLengths(bls12_384_mul_params, numPairs, pairs);
        return true;
    }

    function testFormAddG1InputBLS12_384_M() public view returns (bool) {
        bytes memory correctInput = hex"0131026d331f7ce9cdc5e48d73aeedf0a1d7f7870b788046ec2aff712eda78d3fe42dfb8fe05c47ae860b05717583ae170045d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012103c192577dfb697d258e5f48f4c3f36bb518d0ea9b498ca3559dfb03a2c685a52900b1d9d7d4e19966f41ed390530d41eebaaa1c707c3fb44303ae58df3c9e9c0589b4692a397ecdc90103df90ba78fb4a1c01af3190c07b6494b12dba8aae83c6f5a61251f82bdddcf4a00d0e8277cab9a7febdbbdb3f961ba3a2b38b9ad7a6a3cf4902479e227b1762e5a8322ab109842fc1e481440020137ef6cd6282796bad37b95877281633289033017183acf2472e2b6c01851c8aab7868d17dc6bf38ba905a19ab8bcf308f1b417e833fa548f6a33afb4b91488d829cf924caeab5c09ad4593663";
        bytes memory p1 = hex"00b1d9d7d4e19966f41ed390530d41eebaaa1c707c3fb44303ae58df3c9e9c0589b4692a397ecdc90103df90ba78fb4a1c01af3190c07b6494b12dba8aae83c6f5a61251f82bdddcf4a00d0e8277cab9a7febdbbdb3f961ba3a2b38b9ad7a6a3cf49";
        bytes memory p2 = hex"02479e227b1762e5a8322ab109842fc1e481440020137ef6cd6282796bad37b95877281633289033017183acf2472e2b6c01851c8aab7868d17dc6bf38ba905a19ab8bcf308f1b417e833fa548f6a33afb4b91488d829cf924caeab5c09ad4593663";
        (bytes memory input, uint _) = GenericEllipticCurve.formG1AddInput(bls12_384_mul_params, p1, p2);
        return HelpersForTests.equal(input, correctInput);
    }

    function testFormMulG1InputBLS12_384_M() public view returns (bool) {
        bytes memory correctInput = hex"0231026d331f7ce9cdc5e48d73aeedf0a1d7f7870b788046ec2aff712eda78d3fe42dfb8fe05c47ae860b05717583ae170045d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012103c192577dfb697d258e5f48f4c3f36bb518d0ea9b498ca3559dfb03a2c685a52900b1d9d7d4e19966f41ed390530d41eebaaa1c707c3fb44303ae58df3c9e9c0589b4692a397ecdc90103df90ba78fb4a1c01af3190c07b6494b12dba8aae83c6f5a61251f82bdddcf4a00d0e8277cab9a7febdbbdb3f961ba3a2b38b9ad7a6a3cf4901a377718a6300d8dfa68b483f26b2d31c2501427bf56373224e9a7e9d15cabfc9";
        bytes memory p = hex"00b1d9d7d4e19966f41ed390530d41eebaaa1c707c3fb44303ae58df3c9e9c0589b4692a397ecdc90103df90ba78fb4a1c01af3190c07b6494b12dba8aae83c6f5a61251f82bdddcf4a00d0e8277cab9a7febdbbdb3f961ba3a2b38b9ad7a6a3cf49";
        bytes memory mul = hex"01a377718a6300d8dfa68b483f26b2d31c2501427bf56373224e9a7e9d15cabfc9";
        (bytes memory input, uint _) = GenericEllipticCurve.formG1MulInput(bls12_384_mul_params, p, mul);
        return HelpersForTests.equal(input, correctInput);
    }

    function testFormMultiExpG1InputBLS12_384_M() public view returns (bool) {
        bytes memory correctInput = hex"0331026d331f7ce9cdc5e48d73aeedf0a1d7f7870b788046ec2aff712eda78d3fe42dfb8fe05c47ae860b05717583ae170045d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012103c192577dfb697d258e5f48f4c3f36bb518d0ea9b498ca3559dfb03a2c685a5290300b1d9d7d4e19966f41ed390530d41eebaaa1c707c3fb44303ae58df3c9e9c0589b4692a397ecdc90103df90ba78fb4a1c01af3190c07b6494b12dba8aae83c6f5a61251f82bdddcf4a00d0e8277cab9a7febdbbdb3f961ba3a2b38b9ad7a6a3cf4901a377718a6300d8dfa68b483f26b2d31c2501427bf56373224e9a7e9d15cabfc900b1d9d7d4e19966f41ed390530d41eebaaa1c707c3fb44303ae58df3c9e9c0589b4692a397ecdc90103df90ba78fb4a1c01af3190c07b6494b12dba8aae83c6f5a61251f82bdddcf4a00d0e8277cab9a7febdbbdb3f961ba3a2b38b9ad7a6a3cf4901a377718a6300d8dfa68b483f26b2d31c2501427bf56373224e9a7e9d15cabfc900b1d9d7d4e19966f41ed390530d41eebaaa1c707c3fb44303ae58df3c9e9c0589b4692a397ecdc90103df90ba78fb4a1c01af3190c07b6494b12dba8aae83c6f5a61251f82bdddcf4a00d0e8277cab9a7febdbbdb3f961ba3a2b38b9ad7a6a3cf4901a377718a6300d8dfa68b483f26b2d31c2501427bf56373224e9a7e9d15cabfc9";
        uint8 numPairs = 3;
        bytes memory pairs = hex"00b1d9d7d4e19966f41ed390530d41eebaaa1c707c3fb44303ae58df3c9e9c0589b4692a397ecdc90103df90ba78fb4a1c01af3190c07b6494b12dba8aae83c6f5a61251f82bdddcf4a00d0e8277cab9a7febdbbdb3f961ba3a2b38b9ad7a6a3cf4901a377718a6300d8dfa68b483f26b2d31c2501427bf56373224e9a7e9d15cabfc900b1d9d7d4e19966f41ed390530d41eebaaa1c707c3fb44303ae58df3c9e9c0589b4692a397ecdc90103df90ba78fb4a1c01af3190c07b6494b12dba8aae83c6f5a61251f82bdddcf4a00d0e8277cab9a7febdbbdb3f961ba3a2b38b9ad7a6a3cf4901a377718a6300d8dfa68b483f26b2d31c2501427bf56373224e9a7e9d15cabfc900b1d9d7d4e19966f41ed390530d41eebaaa1c707c3fb44303ae58df3c9e9c0589b4692a397ecdc90103df90ba78fb4a1c01af3190c07b6494b12dba8aae83c6f5a61251f82bdddcf4a00d0e8277cab9a7febdbbdb3f961ba3a2b38b9ad7a6a3cf4901a377718a6300d8dfa68b483f26b2d31c2501427bf56373224e9a7e9d15cabfc9";
        (bytes memory input, uint _) = GenericEllipticCurve.formG1MultiExpInput(bls12_384_mul_params, numPairs, pairs);
        return HelpersForTests.equal(input, correctInput);
    }

    // function testFormMulG1Input(
    //     uint px, uint py,
    //     bytes memory factor,
    //     bytes memory correctInput
    // ) public view returns (bool) {
    //     CommonTypes.G1Point memory p = CommonTypes.G1Point({
    //         X: px,
    //         Y: py
    //     });
    //     (bytes memory input, uint _) = GenericEllipticCurve.formG1MulInput(curveParams, p, factor);
    //     return HelpersForTests.equal(input, correctInput);
    // }

    // function testFormMultiExpG1Input(
    //     uint8 numPairs,
    //     uint px, uint py,
    //     bytes memory order,
    //     bytes memory correctInput
    // ) public view returns (bool) {
    //     CommonTypes.G1Point memory p = CommonTypes.G1Point({
    //         X: px,
    //         Y: py
    //     });
    //     (bytes memory input, uint _) = GenericEllipticCurve.formG1MultiExpInput(curveParams, numPairs, p, order);
    //     return HelpersForTests.equal(input, correctInput);
    // }

    // function testFormAddG2Input(
    //     uint p1x0, uint p1x1,
    //     uint p1y0, uint p1y1,
    //     uint p2x0, uint p2x1,
    //     uint p2y0, uint p2y1,
    //     bytes memory correctInput
    // ) public view returns (bool) {
    //     CommonTypes.G2Point memory p1 = CommonTypes.G2Point({
    //         X: [p1x0, p1x1],
    //         Y: [p1y0, p1y1]
    //     });
    //     CommonTypes.G2Point memory p2 = CommonTypes.G2Point({
    //         X: [p2x0, p2x1],
    //         Y: [p2y0, p2y1]
    //     });
    //     (bytes memory input, uint _) = GenericEllipticCurve.formG2AddInput(curveParams, p1, p2);
    //     return HelpersForTests.equal(input, correctInput);
    // }

    // function testFormMulG2Input(
    //     uint px0, uint px1,
    //     uint py0, uint py1,
    //     bytes memory factor,
    //     bytes memory correctInput
    // ) public view returns (bool) {
    //     CommonTypes.G2Point memory p = CommonTypes.G2Point({
    //         X: [px0, px1],
    //         Y: [py0, py1]
    //     });
    //     (bytes memory input, uint _) = GenericEllipticCurve.formG2MulInput(curveParams, p, factor);
    //     return HelpersForTests.equal(input, correctInput);
    // }

    // function testFormMultiExpG2Input(
    //     uint8 numPairs,
    //     uint px0, uint px1,
    //     uint py0, uint py1,
    //     bytes memory order,
    //     bytes memory correctInput
    // ) public view returns (bool) {
    //     CommonTypes.G2Point memory p = CommonTypes.G2Point({
    //         X: [px0, px1],
    //         Y: [py0, py1]
    //     });
    //     (bytes memory input, uint _) = GenericEllipticCurve.formG2MultiExpInput(curveParams, numPairs, p, order);
    //     return HelpersForTests.equal(input, correctInput);
    // }

    // function testFormPairingInput(
    //     uint[2] memory g1p1,
    //     uint[4] memory g2p1,
    //     uint[2] memory g1p2,
    //     uint[4] memory g2p2,
    //     bytes memory correctInput
    // ) public view returns (bool) {
    //     CommonTypes.Pair memory pair1 = CommonTypes.Pair({
    //         g1p: CommonTypes.G1Point({
    //             X: g1p1[0],
    //             Y: g1p1[1]
    //         }),
    //         g2p: CommonTypes.G2Point({
    //             X: [g2p1[0], g2p1[1]],
    //             Y: [g2p1[2], g2p1[3]]
    //         })
    //     });
    //     CommonTypes.Pair memory pair2 = CommonTypes.Pair({
    //         g1p: CommonTypes.G1Point({
    //             X: g1p2[0],
    //             Y: g1p2[1]
    //         }),
    //         g2p: CommonTypes.G2Point({
    //             X: [g2p2[0], g2p2[1]],
    //             Y: [g2p2[2], g2p2[3]]
    //         })
    //     });
    //     CommonTypes.Pair[] memory resPairs = new CommonTypes.Pair[](2);
    //     resPairs[0] = pair1;
    //     resPairs[1] = pair2;

    //     (bytes memory input, uint _) = GenericEllipticCurve.formPairingInput(curveParams, resPairs);
    //     return HelpersForTests.equal(input, correctInput);
    // }

}