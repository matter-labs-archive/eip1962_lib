pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2;

import {CommonTypes} from "../contracts/CommonTypes.sol";

library PrebuildCurves {
    function bn256() public pure returns (CommonTypes.CurveParams memory params) {
        params = CommonTypes.CurveParams({
            curveType: 0x01,
            fieldLength: 0x01,
            baseFieldModulus: "0x01",
            extensionDegree: 0x01,
            a: "0x01",
            b: "0x01",
            groupOrderLength: 0x01,
            groupOrder: "0x01",
            fpNonResidue: "0x01",
            mainSubgroupOrder: "0x01",
            fp2NonResidue: "0x01",
            fp6NonResidue: "0x01",
            twistType: 0x01,
            xLength: 0x01,
            x: "0x01",
            sign: 0x01
        });
    }

    function bls12_381() public pure returns (CommonTypes.CurveParams memory params) {
        params = CommonTypes.CurveParams({
            curveType: 0x01,
            fieldLength: 0x01,
            baseFieldModulus: "0x01",
            extensionDegree: 0x01,
            a: "0x01",
            b: "0x01",
            groupOrderLength: 0x01,
            groupOrder: "0x01",
            fpNonResidue: "0x01",
            mainSubgroupOrder: "0x01",
            fp2NonResidue: "0x01",
            fp6NonResidue: "0x01",
            twistType: 0x01,
            xLength: 0x01,
            x: "0x01",
            sign: 0x01
        });
    }

    function undefined() public pure returns (CommonTypes.CurveParams memory params) {
        params = CommonTypes.CurveParams({
            curveType: 0x00,
            fieldLength: 0x00,
            baseFieldModulus: "0x00",
            extensionDegree: 0x00,
            a: "0x00",
            b: "0x00",
            groupOrderLength: 0x00,
            groupOrder: "0x00",
            fpNonResidue: "0x00",
            mainSubgroupOrder: "0x00",
            fp2NonResidue: "0x00",
            fp6NonResidue: "0x00",
            twistType: 0x00,
            xLength: 0x00,
            x: "0x00",
            sign: 0x00
        });
    }
}