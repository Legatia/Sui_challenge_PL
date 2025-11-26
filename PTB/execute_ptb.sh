#!/bin/bash

# Package IDs
CHALLENGE_PACKAGE="0x681c6cf2f87e99b24096e64feece5a5f3b12d730a1f0c63b2c1dde7e700a5738"
YOUR_PACKAGE="0x32d5afb316836b7a00aec9c3f26a731283101da43105c202494c752de95ad702"

echo "Executing Programmable Transaction Block..."
echo "Challenge Package: $CHALLENGE_PACKAGE"
echo "Your Package: $YOUR_PACKAGE"
echo ""

# Execute the PTB
# Step 1: Create the object and assign it to 'obj'
# Step 2: Call emit_event with a reference to 'obj'
# Step 3: Destroy 'obj'
sui client ptb \
  --move-call $CHALLENGE_PACKAGE::transaction_blocks::create_object \
  --assign obj \
  --move-call $YOUR_PACKAGE::ptb::emit_event obj \
  --move-call $CHALLENGE_PACKAGE::transaction_blocks::destroy_object obj \
  --gas-budget 10000000

echo ""
echo "PTB execution complete!"
