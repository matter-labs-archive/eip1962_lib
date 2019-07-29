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

  it('Concat', async () => {
    let contractAddress = test.address;
    let contract = new ethers.Contract(contractAddress, TEST_CONTRACT.abi, provider);

    let concat = await contract.testConcat();
    expect(concat).not.to.be.None;
  });
});