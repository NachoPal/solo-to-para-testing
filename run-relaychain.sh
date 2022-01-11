#!/bin/bash

###############################################################################
### Run Relay Chain ###########################################################
###############################################################################

echo "Relaychain start up"

# ./bin/polkadot build-spec\
#   --disable-default-bootnode\
#   --chain $RUNTIME_RELAY_SOURCE > ./resources/chain-specs/source.json

# ./bin/polkadot build-spec\
#   --chain ./resources/chain-specs/source.json\
#   --raw\
#   --disable-default-bootnode > ./resources/chain-specs/source-raw.json

# RUST_LOG=runtime=trace,runtime::bridge=trace,runtime::bridge-messages=trace
RUST_LOG=system=debug,paras=debug,nacho=debug,parachain::candidate-validation=debug,parachain::availability,runtime::inclusion,parachain::collation-generation=trace,parachain::candidate-backing=trace,parachain::bitfield-signing=trace,parachain::approval-voting=trace,parachain::availability-recovery=trace,parachain::availability-distribution=trace
export RUST_LOG

# start nodes
./bin/polkadot\
  --tmp\
	--chain=./resources/polkadot-local-raw.json\
	--alice\
	--port=30333\
	--rpc-port=9933\
	--ws-port=9944\
	--execution=wasm\
	--rpc-cors=all\
	--unsafe-rpc-external\
	--unsafe-ws-external &> ./logs/alice.log&

./bin/polkadot\
  --tmp\
	--chain=./resources/polkadot-local-raw.json\
	--bob\
	--port=30334\
	--rpc-port=9934\
	--ws-port=9955\
	--execution=wasm\
	--rpc-cors=all\
	--unsafe-rpc-external\
	--unsafe-ws-external &> ./logs/bob.log&