pragma solidity ^0.5.1;

import {Bytes} from "../contracts/Bytes.sol";
import {HelpersForTests} from "../test/HelpersForTests.sol";

contract TestBytes {
    function testConcat() internal pure {
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
            "testConcat failed"
        );
    }
}