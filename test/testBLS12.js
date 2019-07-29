require('dotenv').config()
const chai = require('chai');
const {deployContract, solidity} = require('ethereum-waffle');
const ethers = require('ethers');

const TEST_CONTRACT = require('../build/TestBLS12');

chai.use(solidity);
const {expect} = chai;

describe('Test BLS12', () => {
  let provider = new ethers.providers.JsonRpcProvider(process.env.JSON_RPC_URL);
  let wallet = new ethers.Wallet(process.env.WALLET_PK, provider);
  let test;

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
  });

  it('G1 Add', async () => {
    let contractAddress = test.address;
    let contract = new ethers.Contract(contractAddress, TEST_CONTRACT.abi, provider);

    let g1Add = await contract.testAddG1();
    expect(g1Add).not.to.be.None;
  });

  it('G1 Mul', async () => {
    let contractAddress = test.address;
    let contract = new ethers.Contract(contractAddress, TEST_CONTRACT.abi, provider);

    let g1Mul = await contract.testMulG1();
    expect(g1Mul).not.to.be.None;
  });

  it('G1 MultiExp', async () => {
    let contractAddress = test.address;
    let contract = new ethers.Contract(contractAddress, TEST_CONTRACT.abi, provider);

    let g1MultiExp = await contract.testMultiExpG1();
    expect(g1MultiExp).not.to.be.None;
  });

  it('G2 Add', async () => {
    let contractAddress = test.address;
    let contract = new ethers.Contract(contractAddress, TEST_CONTRACT.abi, provider);

    let g2Add = await contract.testAddG2();
    expect(g2Add).not.to.be.None;
  });

  it('G2 Mul', async () => {
    let contractAddress = test.address;
    let contract = new ethers.Contract(contractAddress, TEST_CONTRACT.abi, provider);

    let g2Mul = await contract.testMulG2();
    expect(g2Mul).not.to.be.None;
  });

  it('G2 MultiExp', async () => {
    let contractAddress = test.address;
    let contract = new ethers.Contract(contractAddress, TEST_CONTRACT.abi, provider);

    let g2MultiExp = await contract.testMultiExpG2();
    expect(g2MultiExp).not.to.be.None;
  });

  it('Pairing', async () => {
    let contractAddress = test.address;
    let contract = new ethers.Contract(contractAddress, TEST_CONTRACT.abi, provider);

    let pairing = await contract.testPairing();
    expect(pairing).not.to.be.None;
  });
});