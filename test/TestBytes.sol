pragma solidity ^0.5.1;

import {Bytes} from "../contracts/Bytes.sol";
import {HelpersForTests} from "../test/HelpersForTests.sol";

contract TestBytes {

    function testEqual(bytes memory lhs, bytes memory rhs) public pure returns (bool) {
        return HelpersForTests.equal(lhs, rhs);
    }

    function testSliceCorrect(
        bytes memory slice,
        uint start,
        uint length,
        bytes memory correctResult
    )  public pure returns (bool) {
        return HelpersForTests.equal(
            Bytes.slice(slice, start, length),
            correctResult
        );
    }

    function testToBytesFromUIntCorrect(uint number, uint bytesLength, bytes memory correctResult) public pure returns (bool) {
        return HelpersForTests.equal(
            Bytes.toBytesFromUInt(number, bytesLength),
            correctResult
        );
    }

    function testToBytesFromUInt8Correct(uint8 number, bytes memory correctResult) public pure returns (bool) {
        return HelpersForTests.equal(
            Bytes.toBytesFromUInt8(number),
            correctResult
        );
    }

    function testConcatEqual(bytes memory firstBytes, bytes memory secondBytes, bytes memory correctResult) public pure returns (bool) {
        bytes memory resultBytes = Bytes.concat(firstBytes, secondBytes);
        return HelpersForTests.equal(
            resultBytes,
            correctResult
        );
    }
}