#!/bin/sh

../../graphql-bench/app/cli/bin/run query \
  --config="./bench.config.yaml" \
  --outfile="./bench.output.json"
