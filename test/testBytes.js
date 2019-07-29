require('dotenv').config()
const chai = require('chai');
const {deployContract, solidity} = require('ethereum-waffle');
const ethers = require('ethers');

const TEST_CONTRACT = require('../build/TestBytes');

chai.use(solidity);
const {expect} = chai;

describe('Test Bytes', () => {
  let provider = new ethers.providers.JsonRpcProvider(process.env.JSON_RPC_URL);
  let wallet = new ethers.Wallet(process.env.WALLET_PK, provider);
  let test;
  let contract;

  beforeEach(async () => {
    test = await deployContract(wallet, TEST_CONTRACT, [], {
      gasLimit: 4700000
    });
    expect(test.address).to.be.properAddress;
    console.log("Test address:" + test.address);
    contract = new ethers.Contract(test.address, TEST_CONTRACT.abi, provider);
  });

  it('Equal', async () => {
    let result = await contract.testEqual(["0x00", "0xaa", "0xff"], ["0x00", "0xaa", "0xff"]);
    expect(result).to.eq(true);
  });

  it('Not equal', async () => {
    let result = await contract.testEqual(["0x00", "0xaa", "0xf1"], ["0x00", "0xaa", "0xff"]);
    expect(result).to.eq(false);
  });

  it('Slice correct', async () => {
    let result = await contract.testSliceCorrect(["0x00", "0xaa", "0xf1", "0xab", "0x51"], 2, 2, ["0xf1", "0xab"]);
    expect(result).to.eq(true);
  });

  it('Slice not correct', async () => {
    let result = await contract.testSliceCorrect(["0x00", "0xaa", "0xf1", "0xab", "0x51"], 2, 2, ["0xaa", "0xf1"]);
    expect(result).to.eq(false);
  });

  it('To bytes from uint correct', async () => {
    let result = await contract.testToBytesFromUIntSuccess(257, 4, ["0x00",  "0x00",  "0x01",  "0x01"]);
    expect(result).to.eq(true);
  });

  it('To bytes from uint not correct', async () => {
    let result = await contract.testToBytesFromUIntCorrect(259, 4, ["0x00",  "0x00",  "0x01",  "0x01"]);
    expect(result).to.eq(false);
  });

  it('To bytes from uint8 correct', async () => {
    let result = await contract.testToBytesFromUInt8Success(128, ["0x80"]);
    expect(result).to.eq(true);
  });

  it('To bytes from uint8 not correct', async () => {
    let result = await contract.testToBytesFromUInt8Correct(128, ["0x81"]);
    expect(result).to.eq(false);
  });

  it('Concat correct', async () => {
    let result = await contract.testConcatEqual(["0x02", "0x82"], ["0x12", "0xf2"], ["0x02", "0x82", "0x12", "0xf2"]);
    expect(result).to.eq(true);
  });

  it('Concat not correct', async () => {
    let result = await contract.testConcatEqual(["0x02", "0x82"], ["0x12", "0xf2"], ["0x01", "0x82", "0x12", "0xf2"]);
    expect(result).to.eq(false);
  });
});