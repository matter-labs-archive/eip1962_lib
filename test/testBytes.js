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

  beforeEach(async () => {
    test = await deployContract(wallet, TEST_CONTRACT, [], {
      gasLimit: 8000000
    });
    expect(test.address).to.be.properAddress;
    console.log("Test address:" + test.address);
  });

  it('Equal', async () => {
    let contractAddress = test.address;
    let contract = new ethers.Contract(contractAddress, TEST_CONTRACT.abi, provider);

    let concat = await contract.testEqual();
    expect(concat).not.to.be.None;
  });

  it('Not equal 1', async () => {
    let contractAddress = test.address;
    let contract = new ethers.Contract(contractAddress, TEST_CONTRACT.abi, provider);

    let concat = await contract.testNotEqual1();
    expect(concat).not.to.be.None;
  });

  it('Not equal 2', async () => {
    let contractAddress = test.address;
    let contract = new ethers.Contract(contractAddress, TEST_CONTRACT.abi, provider);

    let concat = await contract.testNotEqual2();
    expect(concat).not.to.be.None;
  });

  it('Not equal 3', async () => {
    let contractAddress = test.address;
    let contract = new ethers.Contract(contractAddress, TEST_CONTRACT.abi, provider);

    let concat = await contract.testNotEqual3();
    expect(concat).not.to.be.None;
  });

  it('Not equal 4', async () => {
    let contractAddress = test.address;
    let contract = new ethers.Contract(contractAddress, TEST_CONTRACT.abi, provider);

    let concat = await contract.testNotEqual4();
    expect(concat).not.to.be.None;
  });

  it('Not equal 5', async () => {
    let contractAddress = test.address;
    let contract = new ethers.Contract(contractAddress, TEST_CONTRACT.abi, provider);

    let concat = await contract.testNotEqual5();
    expect(concat).not.to.be.None;
  });

  it('Concat equal', async () => {
    let contractAddress = test.address;
    let contract = new ethers.Contract(contractAddress, TEST_CONTRACT.abi, provider);

    let concat = await contract.testConcatEqual();
    expect(concat).not.to.be.None;
  });

  it('Concat not equal', async () => {
    let contractAddress = test.address;
    let contract = new ethers.Contract(contractAddress, TEST_CONTRACT.abi, provider);

    let concat = await contract.testConcatNotEqual();
    expect(concat).not.to.be.None;
  });
});