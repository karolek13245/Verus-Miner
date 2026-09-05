#!/data/data/com.termux/files/usr/bin/bash
# ═══════════════════════════════════════════════════════
#  EXAMPLE CONFIGURATION FILE
#  Copy this to ~/startup.sh and modify
# ═══════════════════════════════════════════════════════

# ─── POOL CONFIGURATION ────────────────────────────
# Choose your mining pool:

# Luckpool (North America)
POOL="stratum+tcp://na.luckpool.net:3956"
# Luckpool (Europe)
# POOL="stratum+tcp://eu.luckpool.net:3956"
# Luckpool (Asia)
# POOL="stratum+tcp://asia.luckpool.net:3956"
# Vipor.net
# POOL="stratum+tcp://us.vipor.net:5040"

# ─── WALLET CONFIGURATION ──────────────────────────
# Your Verus Coin address (starts with R)
# Example: R123456789abcdefghijklmnopqrstuvwxyz
WALLET="Rxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# ─── WORKER CONFIGURATION ──────────────────────────
# Name to identify your device in pool stats
WORKER="android_$(hostname | cut -c1-8)"

# ─── THREAD CONFIGURATION ──────────────────────────
# Number of CPU threads to use
# Default: 4, Max: $(nproc)
THREADS=4

# ─── ADVANCED OPTIONS ──────────────────────────────
# Set CPU priority (nice value)
# Range: -20 (highest) to 19 (lowest)
# NICE=19

# Donation (percentage of hashrate to donate to dev)
# DONATE=1

# ─── START MINING ──────────────────────────────────
# screen -dmS miner ~/ccminer/ccminer -a verus \
#     -o $POOL \
#     -u $WALLET.$WORKER \
#     -p x \
#     -t $THREADS
# 
# echo "Miner started with $THREADS threads"