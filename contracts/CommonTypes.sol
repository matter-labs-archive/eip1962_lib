pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2;

import {Bytes} from "../contracts/Bytes.sol";

library CommonTypes {
    // Curve parameters struct
    struct CurveParams {
        uint8 curveType;
        uint8 fieldLength;
        bytes baseFieldModulus;
        uint8 extensionDegree;
        bytes a;
        bytes b;
        uint8 groupOrderLength;
        bytes groupOrder;
        bytes fpNonResidue;
        bytes mainSubgroupOrder;
        bytes fp2NonResidue;
        bytes fp6NonResidue;
        uint8 twistType;
        uint8 xLength;
        bytes x;
        uint8 sign;
    }

    // Enum describes possible curves.
    // 'Custom' is user defined curve.
    // 'Undefined' curve is undefined;
    enum PrebuildCurveTypes {
        BLS12_384_m,
        BLS12_384_d,
        BLS12_381_m,
        BLS12_381_d
    }
}