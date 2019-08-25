---
layout: post
title:  "Terms in the Blockchain world"
date:   2019-07-10 12:20:17 +0200
categories: blockchain
---
# Terms you encounter in the Blockchain World

When i started playing with blockchain technology the first hurdle was managing all the terms related to blockchain, bitcoin, dlt...

I've tried to describe the terms with my own words. But most of them are linked to wikipedia for more detailed information.

|Term|Description|
|---|---|
|Block|[Block (blockchain)](https://en.wikipedia.org/wiki/Block_(blockchain)): Single unit of information stored in a BlockChain. Consists of two parts: metadata and payload (e.g. transactions)|
|BlockChain| [BlockChain](https://de.wikipedia.org/wiki/Blockchain): List of Blocks. Each block is connected to its predecessor by its hash value. It is copied to each _Node_ participating in this _BlockChain_.  |
|Node|Computer in a _BlockChain_. Each node has a full copy of the _BlockChain_ and each node _validates_ every _Block_ in it's copy|
|Hash| Unique value build from a blocks metadata and payload. Calculated by using [Cryptographic hash functions ](https://en.wikipedia.org/wiki/Cryptographic_hash_function) |
|Nonce| [Crypto Nonce](https://en.wikipedia.org/wiki/Cryptographic_nonce#Hashing): Property of _Block_ metadata. Used to alter the blocks _Hash_ value until it meets the _BockChains_ constraints |
|Ledger|[What _blockchains_ do](https://en.wikipedia.org/wiki/Ledger): recording changes to a certain entity. In case of _bitcoin_ its deposit and withdrawl of bitcoins (or fractions of bitcoins|
|Consensus|All (full) Nodes in a Blochain have to have the same outcome of applied validation rules. Refer to _mining_ section for the _BitCoin_ rules. Depending on the _BlockChain_ rules may be different. [BitCoin Wiki is more precise](https://en.bitcoin.it/wiki/Consensus)|
|Mining| Finding a hash value for a certain block which meets the contraints of the blockchain. [BitCoin consens rules](https://bitcoin.org/en/blockchain-guide#transaction-data) are shown for the most popular example. Refer to [this to see how BitCoin mining is performed](https://en.wikipedia.org/wiki/Bitcoin_network#Process)|
|DLT|[DLT](https://de.wikipedia.org/wiki/Distributed-Ledger-Technologie): Distributed Ledger Technology. Acronym for blockchains. |
|Smart Contract|[Smart Contract](https://en.wikipedia.org/wiki/Smart_contract): Piece of code stored in a block. The code is executed automatically whenever the conditions are met. [How do Smart Contracts work?](https://www.bitdegree.org/tutorials/what-is-a-smart-contract/)|
|Chain Code|same as _Smart Contract_|
|![BitCoin](https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Bitcoin_logo.svg/307px-Bitcoin_logo.svg.png)|[BitCoin](https://de.wikipedia.org/wiki/Bitcoin) is two things 1. The first blockchain. Started on Jan, 3. 2009 By Satoshi Nakamoto. 2. (Crypto-)Currency|
|Crypto Currency|Digital medium of exchange that incorporates strong cryptography [Wikipedia: Crypto Currency](https://en.wikipedia.org/wiki/Cryptocurrency)|
|![Ethereum](https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Ethereum_logo.svg/150px-Ethereum_logo.svg.png)|[Ethereum](https://en.wikipedia.org/wiki/Ethereum): Second largest _BlockChain_ which supports _Smart Contracts_|
|Ether| [Ether](https://en.wikipedia.org/wiki/Ethereum#Ether): Currency on the _ethereum_ blockchain to reward _miners_|
|Miner|[Miner](https://en.wikipedia.org/wiki/Miner#Cryptocurrency_miners): People/Computers validating new _blocks_ and appending them to the _blockchain_|
|Validation|Checking a blocks information whether id meets the contraints of the very _blockchain_|
|Wei| [Wei](https://en.wikipedia.org/wiki/Ethereum#Ether): special form of currency in ethereum|
|Gas| [Gas](https://en.wikipedia.org/wiki/Ethereum#Ether): special form of currency in ethereum|
|Satoshi Nakamoto|[Satoshi Nakamoto](https://de.wikipedia.org/wiki/Satoshi_Nakamoto): Alias of the inventor of the _BitCoin_ blockchain. It is unknown who this really is|
|Proof of work| [PoW](https://en.wikipedia.org/wiki/Proof_of_work): Way to stop _miners_ from flodding a _blockchain_ by making it difficult to find valid new blocks by requiring them to invest lots of energy|
|Proof of stake| [PoS](https://en.wikipedia.org/wiki/Proof_of_stake):Similar to _proof of work_ but more energy efficient. But not easier to solve|
|SHA-256|[Cryptographic hash function](https://en.wikipedia.org/wiki/SHA-2) used in _BitCoin_ to implement _Proof of work_|
|Tezos|[Tezos is an _Ethereum_ alternativ by Dynamic Ledger Solutions.](https://tezos.com)|
|![SegWit](https://blockchainwelt.de/wp-content/uploads/2018/06/segwit-bitcoin-logo.png)|[Compatible attempt to cope with _BitCoins_ transaction limitation](https://de.wikipedia.org/wiki/SegWit)|
|p2sh|[Pay to Script Hash](https://en.bitcoin.it/wiki/Pay_to_script_hash): Secure way to perform a bitcoin transaction|
|Schnorr, Taproot|[Attempt to increase privacy](https://www.btc-echo.de/wie-taproot-und-schnorr-bitcoins-privacy-verbessern-wird-code-in-github-lanciert/)|



