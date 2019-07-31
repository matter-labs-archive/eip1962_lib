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

    // G1 Point
    struct G1Point {
        uint X;
        uint Y;
    }

    // G2 Point
    struct G2Point {
        uint[2] X;
        uint[2] Y;
    }

    // Points pair
    struct Pair {
        G1Point g1p;
        G2Point g2p;
    }

    // Enum describes possible curves.
    // 'Custom' is user defined curve.
    // 'Undefined' curve is undefined;
    enum CurveTypes {
        Bn256,
        Bls12_381,
        Custom,
        Undefined
    }
}