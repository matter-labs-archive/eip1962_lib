# TESTING

## Parity + Waffle

Clone this repo
```shell
git clone https://github.com/matter-labs/eip1962_lib
```

Clone parity client with EIP1962 precompile
```shell
git clone -b eip1962 https://github.com/matter-labs/parity-ethereum
```

Run parity client from its folder
```shell
cargo run --bin=parity --package=parity-ethereum --message-format=json -- --config dev-insecure --unsafe-expose --chain ethcore/res/eip_1962.json --jsonrpc-cors=all
```

Install dependencis for library. Go to eip1962_lib folder and run
```shell
yarn
```

Compile contracts and run tests
```shell
npx waffle && npx mocha
```

## Geth + Truffle

Install truffle
```shell
npm install -g truffle
```

Clone this repo
```shell
git clone https://github.com/matter-labs/eip1962_lib
```

Clone geth client with EIP1962 precompile
```shell
git clone -b eip1962 https://github.com/matter-labs/go-ethereum
```

Create genesis.json file in geth folder to configure private chain
```json
{
    "config": {
        "chainId": 10,
        "homesteadBlock": 0,
        "eip155Block": 0,
        "eip158Block": 0
    },
    "alloc": {
        "0x00a329c0648769a73afac7f9381e08fb43dbea72": {
            "balance": "10000000000000000000000"
        }
    },
    "coinbase": "0x0000000000000000000000000000000000000000",
    "difficulty": "0x20000",
    "extraData": "",
    "gasLimit": "0xFFFFFFFF",
    "nonce": "0x0000000000000042",
    "mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "timestamp": "0x00"
}
```

Build geth and helper tools. Run in geth folder
```shell
make all
```

Init geth with created genesis.json
```shell
./build/bin/geth --datadir ./datadir init ./genesis.json
```

Run geth with console 
```shell
./build/bin/geth --datadir ./datadir --rpc --rpcport 8545 --rpcaddr 127.0.0.1 --rpccorsdomain "*" --rpcapi "eth,net,web3" --port 3000 --networkid 58342 --nodiscover --allow-insecure-unlock console
```

Import account from console
```shell
web3.personal.importRawKey("4d5db4107d237df6a3d58ee5f70ae63d73d7658d4026f2eefd2f204c81682cb7", "")
```

Unlock account from console
```shell
personal.unlockAccount(eth.accounts[0],"")
```

Run miner
```shell
miner.start(1)
```

Install dependencis for library. Go to eip1962_lib folder and run
```shell
yarn
```

Run migrations
```shell
truffle migrate
```

Run tests
```shell
truffle test
```

Don't forget to stop geth when you finish. Run from console
```shell
exit
```