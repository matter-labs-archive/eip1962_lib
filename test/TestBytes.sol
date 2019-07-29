pragma solidity ^0.5.1;

import {Bytes} from "../contracts/Bytes.sol";
import {HelpersForTests} from "../test/HelpersForTests.sol";

contract TestBytes {

    function testEqual() internal pure {
        require(
            HelpersForTests.equal(
                bytes("number"),
                bytes("number")
            ),
            "testEqual failed"
        );
    }

    function testNotEqual1() internal pure {
        require(
            !HelpersForTests.equal(
                bytes("number"),
                bytes("number1")
            ),
            "testNotEqual1 failed"
        );
    }

    function testNotEqual2() internal pure {
        require(
            !HelpersForTests.equal(
                bytes("number"),
                bytes("2number")
            ),
            "testNotEqual2 failed"
        );
    }

    function testNotEqual3() internal pure {
        require(
            !HelpersForTests.equal(
                bytes("1number"),
                bytes("2number")
            ),
            "testNotEqual3 failed"
        );
    }

    function testNotEqual4() internal pure {
        require(
            !HelpersForTests.equal(
                bytes("number"),
                bytes("numb3r")
            ),
            "testNotEqual4 failed"
        );
    }

    function testNotEqual5() internal pure {
        require(
            !HelpersForTests.equal(
                bytes("number"),
                bytes("numbe3r")
            ),
            "testNotEqual5 failed"
        );
    }

    function testConcatEqual() internal pure {
        bytes memory firstBytes = bytes("f1rstNum6er1");
        bytes memory secondBytes = bytes("sec0ndNum6er2");
        bytes memory thirdBytes = bytes("th1rdNum6er3");
        bytes memory resultBytes = Bytes.concat(firstBytes, secondBytes);
        resultBytes = Bytes.concat(resultBytes, thirdBytes);
        require(
            HelpersForTests.equal(
                bytes("f1rstNum6er1sec0ndNum6er2th1rdNum6er3"),
                resultBytes
            ),
            "testConcatEqual failed"
        );
    }

    function testConcatNotEqual() internal pure {
        bytes memory firstBytes = bytes("f1rstNum6er1");
        bytes memory secondBytes = bytes("sec0ndNum6er2");
        bytes memory thirdBytes = bytes("th1rdNum6er3");
        bytes memory resultBytes = Bytes.concat(firstBytes, secondBytes);
        resultBytes = Bytes.concat(resultBytes, thirdBytes);
        require(
            !HelpersForTests.equal(
                bytes("wrongNumber"),
                resultBytes
            ),
            "testConcatNotEqual failed"
        );
    }
}