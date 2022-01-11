#!/bin/bash

###############################################################################
### Run Seedling ##############################################################
###############################################################################

echo "Seedling start up"

RUST_LOG=runtime=debug,aura=debug,cumulus=debug,cumulus-collator=debug,nacho=debug
export RUST_LOG

# Collator 1
./bin/polkadot-collator\
  --alice\
  --collator\
  --force-authoring\
  --tmp\
  --port 40333\
  --ws-port 9966\
  --execution=wasm\
  --chain=seedling\
  --\
  --execution=wasm\
  --chain=resources/polkadot-local-raw.json\
  --ws-port 9945\
  --port 30335 &> ./logs/seedling-collator-alice.log&

# Collator 2
./bin/polkadot-collator\
  --bob\
  --collator\
  --force-authoring\
  --tmp\
  --port 40334\
  --ws-port 9977\
  --execution=wasm\
  --chain=seedling\
  --\
  --execution=wasm\
  --chain=resources/polkadot-local-raw.json\
  --ws-port 9946\
  --port 30336 &> ./logs/seedling-collator-bob.log&