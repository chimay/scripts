#!/usr/bin/env sh

lim=${1:-75}

echo "echo $lim | sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct"
echo
echo $lim | sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct

echo "echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo"
echo
echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo
