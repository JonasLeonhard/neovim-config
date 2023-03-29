#!/bin/bash
# This script requires:
# nvim --listen ~/.cache/nvim/server.pipe to be set
# aswell as lf run inside to toggle term to have the RUN_INSIDE_NVIM env var to be set.

# seperate multilie selection to one line:
selection=$(echo $fx | tr '\n' ' ')

if [[ ! (-z "$RUN_INSIDE_NVIM") ]]; then
  nvim --server ~/.cache/nvim/server.pipe --remote-send "<C-w>q:args $selection | tab all<CR>";
else
  nvim $selection;
fi
