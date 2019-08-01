require('dotenv').config()
const chai = require('chai');
const {deployContract, solidity} = require('ethereum-waffle');
const ethers = require('ethers');

const TEST_CONTRACT = require('../build/TestInputs');

chai.use(solidity);
const {expect} = chai;

describe('Test Inputs', () => {
  let provider = new ethers.providers.JsonRpcProvider(process.env.JSON_RPC_URL);
  let wallet = new ethers.Wallet(process.env.WALLET_PK, provider);
  let test;
  let contract;

  beforeEach(async () => {
    provider.getBalance(wallet.address).then((balance) => {
      let etherString = ethers.utils.formatEther(balance);
      console.log("Wallet balance: " + etherString);
    });
    test = await deployContract(wallet, TEST_CONTRACT, [], {
      gasLimit: 8000000
    });
    expect(test.address).to.be.properAddress;
    console.log("Test address:" + test.address);
    contract = new ethers.Contract(test.address, TEST_CONTRACT.abi, provider);
  });

  it('G1 op_data for BLS12-384-M curve', async () => {
    let result = await contract.testG1OpDataBLS12_384_M();
    expect(result).to.eq(true);
  });

  it('G2 op_data for BLS12-384-M curve', async () => {
    let result = await contract.testG2OpDataBLS12_384_M();
    expect(result).to.eq(true);
  });

  it('Pairing op_data for BLS12-384-M curve', async () => {
    let result = await contract.testPairingOpDataBLS12_384_M();
    expect(result).to.eq(true);
  });

  // it('G1 Add Input', async () => {
  //   let result = await contract.testFormAddG1Input();
  //   expect(result).to.eq(true);
  // });

  // it('G1 Mul Input', async () => {
  //   let result = await contract.testFormMulG1Input();
  //   expect(result).to.eq(true);
  // });

  // it('G1 MultiExp Input', async () => {
  //   let result = await contract.testFormMultiExpG1Input();
  //   expect(result).to.eq(true);
  // });

  // it('G2 Add Input', async () => {
  //   let result = await contract.testFormAddG2Input();
  //   expect(result).to.eq(true);
  // });

  // it('G2 Mul Input', async () => {
  //   let result = await contract.testFormMulG2Input();
  //   expect(result).to.eq(true);
  // });

  // it('G2 MultiExp Input', async () => {
  //   let result = await contract.testFormMultiExpG2Input();
  //   expect(result).to.eq(true);
  // });

  // it('Pairing Input', async () => {
  //   let result = await contract.testFormPairingInput();
  //   expect(result).to.eq(true);
  // });
});