require('dotenv').config()
const chai = require('chai');
const {deployContract, solidity} = require('ethereum-waffle');
const ethers = require('ethers');

const CURVE_CONTRACT = require('../build/ExampleCurve');

chai.use(solidity);
const {expect} = chai;

describe('Test', () => {
  let provider = new ethers.providers.JsonRpcProvider(process.env.JSON_RPC_URL);
  let wallet = new ethers.Wallet(process.env.WALLET_PK, provider);
  let curve;

  beforeEach(async () => {
    provider.getBalance(wallet.address).then((balance) => {
      let etherString = ethers.utils.formatEther(balance);
      console.log("Wallet balance: " + etherString);
    })
    curve = await deployContract(wallet, ExampleCurve, [], {
      gasLimit: 8000000
    });
    expect(curve.address).to.be.properAddress;
    console.log("EIP lib address:" + curve.address);
  });

  it('G1 Add', async () => {
    let contractAddress = curve.address;
    let contract = new ethers.Contract(contractAddress, CURVE_CONTRACT.abi, provider);

    let g1Add = await contract.g1Add(
      lhs,
      rhs
    );
    console.log(g1Add);
  });

  it('G1 Mul', async () => {
    let contractAddress = curve.address;
    let contract = new ethers.Contract(contractAddress, CURVE_CONTRACT.abi, provider);

    let g1Mul = await contract.g1Mul(
      lhs,
      rhs
    );
    console.log(g1Mul);
  });

  it('G1 MultiExp', async () => {
    let contractAddress = curve.address;
    let contract = new ethers.Contract(contractAddress, CURVE_CONTRACT.abi, provider);

    let g1MultiExp = await contract.g1MultiExp(
      numPairs,
      lhs,
      rhs
    );
    console.log(g1MultiExp);
  });

  it('G2 Add', async () => {
    let contractAddress = curve.address;
    let contract = new ethers.Contract(contractAddress, CURVE_CONTRACT.abi, provider);

    let g2Add = await contract.g2Add(
      lhs,
      rhs
    );
    console.log(g2Add);
  });

  it('G2 Mul', async () => {
    let contractAddress = curve.address;
    let contract = new ethers.Contract(contractAddress, CURVE_CONTRACT.abi, provider);

    let g2Mul = await contract.g2Mul(
      lhs,
      rhs
    );
    console.log(g2Mul);
  });

  it('G2 MultiExp', async () => {
    let contractAddress = curve.address;
    let contract = new ethers.Contract(contractAddress, CURVE_CONTRACT.abi, provider);

    let g2MultiExp = await contract.g2MultiExp(
      numPairs,
      point,
      scalar
    );
    console.log(g2MultiExp);
  });

  it('Pairing', async () => {
    let contractAddress = curve.address;
    let contract = new ethers.Contract(contractAddress, CURVE_CONTRACT.abi, provider);

    let pairing = await contract.pairing(
      numPairs,
      pairs
    );
    console.log(pairing);
  });
});