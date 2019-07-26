pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2;

import {EIP1962} from "../contracts/EIP1962.sol";
import {BLS12} from "../examples/BLS12.sol";

contract Example {

    function testPairing() public view {
        EIP1962.Pair[] memory pairs = EIP1962.Pair[
            EIP1962.Pair(
                EIP1962.G1Point(1, 2),
                EIP1962.G1Point(1, 3)
            )
        ];
        result = BLS12.pairing(pairs);
        require(result, "Wrong pairs");
    }

}