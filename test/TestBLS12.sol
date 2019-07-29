pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2;

import {EIP1962} from "../contracts/EIP1962.sol";
import {BLS12} from "../contracts/BLS12.sol";
import {HelpersForTests} from "../contracts/HelpersForTests.sol";

contract TestBLS12 {

    function testAddG1() public view {
        EIP1962.G1Point memory p1 = EIP1962.G1Point({
            X: 1,
            Y: 2
        });
        EIP1962.G1Point memory p2 = EIP1962.G1Point({
            X: 3,
            Y: 4
        });
        bytes memory result = BLS12.g1Add(p1, p2);
        require(
            HelpersForTests.equal(result, bytes("0x01")),
            "Wrong inputs in testAddG1"
        );
    }

    function testMulG1() public view {
        EIP1962.G1Point memory p = EIP1962.G1Point({
            X: 1,
            Y: 2
        });
        bytes memory result = BLS12.g1Mul(p, "0x02");
        require(
            HelpersForTests.equal(result, bytes("0x01")),
            "Wrong inputs in testMulG1"
        );
    }

    function testMultiExpG1() public view {
        EIP1962.G1Point memory p = EIP1962.G1Point({
            X: 1,
            Y: 2
        });
        bytes memory result = BLS12.g1MultiExp(3, p, "0x05");
        require(
            HelpersForTests.equal(result, bytes("0x01")),
            "Wrong inputs in testMultiExpG1"
        );
    }

    function testAddG2() public view {
        EIP1962.G2Point memory p1 = EIP1962.G2Point({
            X: [11559732032986387107991004021392285783925812861821192530917403151452391805634,
             10857046999023057135944570762232829481370756359578518086990519993285655852781],
            Y: [4082367875863433681332203403145435568316851327593401208105741076214120093531,
             8495653923123431417604973247489272438418190587263600148770280649306958101930]
        });
        EIP1962.G2Point memory p2 = EIP1962.G2Point({
            X: [11559732032986387107991004021392285783925812861821192530917403151452391805634,
             10857046999023057135944570762232829481370756359578518086990519993285655852781],
            Y: [4082367875863433681332203403145435568316851327593401208105741076214120093531,
             8495653923123431417604973247489272438418190587263600148770280649306958101930]
        });
        bytes memory result = BLS12.g2Add(p1, p2);
        require(
            HelpersForTests.equal(result, bytes("0x01")),
            "Wrong inputs in testAddG2"
        );
    }

    function testMulG2() public view {
        EIP1962.G2Point memory p = EIP1962.G2Point({
            X: [11559732032986387107991004021392285783925812861821192530917403151452391805634,
             10857046999023057135944570762232829481370756359578518086990519993285655852781],
            Y: [4082367875863433681332203403145435568316851327593401208105741076214120093531,
             8495653923123431417604973247489272438418190587263600148770280649306958101930]
        });
        bytes memory result = BLS12.g2Mul(p, "0x02");
        require(
            HelpersForTests.equal(result, bytes("0x01")),
            "Wrong inputs in testMulG2"
        );
    }

    function testMultiExpG2() public view {
        EIP1962.G2Point memory p = EIP1962.G2Point({
            X: [11559732032986387107991004021392285783925812861821192530917403151452391805634,
             10857046999023057135944570762232829481370756359578518086990519993285655852781],
            Y: [4082367875863433681332203403145435568316851327593401208105741076214120093531,
             8495653923123431417604973247489272438418190587263600148770280649306958101930]
        });
        bytes memory result = BLS12.g2MultiExp(3, p, "0x05");
        require(
            HelpersForTests.equal(result, bytes("0x01")),
            "Wrong inputs in testMultiExpG2"
        );
    }

    // function testPairing() public view {
    //     EIP1962.Pair[1] storage pairs = EIP1962.Pair[
    //         EIP1962.Pair({
    //             g1p: EIP1962.G1Point({
    //                 X: 1,
    //                 Y: 2
    //             }),
    //             g2p: EIP1962.G2Point({
    //                 X: [11559732032986387107991004021392285783925812861821192530917403151452391805634,
    //                 10857046999023057135944570762232829481370756359578518086990519993285655852781],
    //                 Y: [4082367875863433681332203403145435568316851327593401208105741076214120093531,
    //                 8495653923123431417604973247489272438418190587263600148770280649306958101930]
    //             })
    //         })
    //     ];
    //     bytes memory result = BLS12.pairing(pairs);
    //     require(HelpersForTests.equal(result, bytes("0x01")), "Wrong inputs");
    }

}