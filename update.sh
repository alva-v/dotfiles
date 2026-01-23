#! /bin/bash

set -e

script_dir=$(cd "$(dirname "$0")" &> /dev/null && pwd)
codium --list-extensions > "$script_dir"/non-home/codium-extensions