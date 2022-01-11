#!/bin/bash

###############################################################################
### Run Parachain #############################################################
###############################################################################

echo "Parachain start up"

./bin/polkadot-collator export-genesis-state\
  --parachain-id 2000\
  --chain=westmint-local > ./resources/westmint-local-head-data

#RUST_LOG=runtime=trace,aura=trace,cumulus=trace,cumulus-collator=trace,nacho=trace
RUST_LOG=runtime=debug,aura=debug,cumulus=debug,cumulus-collator=debug,nacho=debug
export RUST_LOG

# Collator 1
./bin/polkadot-collator\
  --alice\
  --collator\
  --force-authoring\
  --tmp\
  --port 40335\
  --ws-port 9988\
  --execution=wasm\
  --chain=westmint-local\
  --\
  --execution=wasm\
  --chain=resources/polkadot-local-raw.json\
  --ws-port 9946\
  --port 30337 &> ./logs/parachain-collator-alice.log&

# Collator 2
./bin/polkadot-collator\
  --bob\
  --collator\
  --force-authoring\
  --tmp\
  --port 40336\
  --ws-port 9999\
  --execution=wasm\
  --chain=westmint-local\
  --\
  --execution=wasm\
  --chain=resources/polkadot-local-raw.json\
  --ws-port 9947\
  --port 30338 &> ./logs/parachain-collator-bob.log&