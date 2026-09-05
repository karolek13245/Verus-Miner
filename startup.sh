#!/data/data/com.termux/files/usr/bin/bash
# ═══════════════════════════════════════════════════════
#  VERUS COIN MINER - STARTUP CONFIG
#  Termux Design by @dendalion.hq 😼
# ═══════════════════════════════════════════════════════

# ─── MINING CONFIGURATION ──────────────────────────
# Change these values before starting!

# Mining Pool (Choose one)
POOL="stratum+tcp://na.luckpool.net:3956"
# POOL="stratum+tcp://eu.luckpool.net:3956"
# POOL="stratum+tcp://asia.luckpool.net:3956"
# POOL="stratum+tcp://us.vipor.net:5040"

# Your Verus Coin Wallet Address
# Get one at: https://verus.io
WALLET="YOUR_WALLET_ADDRESS_HERE"

# Worker Name (identify your device)
WORKER="termux_miner"

# Number of CPU Threads to use
# Check with: nproc
THREADS=4

# ─── START MINER ──────────────────────────────────
# DO NOT EDIT BELOW THIS LINE

# Check for correct binary name
if [ -f ~/ccminer/ccminer ]; then
    MINER_BIN="~/ccminer/ccminer"
elif [ -f ~/ccminer/ccminer-arm ]; then
    MINER_BIN="~/ccminer/ccminer-arm"
else
    echo "❌ Miner binary not found!"
    echo "Please run the installation script first."
    exit 1
fi

screen -dmS miner $MINER_BIN -a verus -o $POOL -u $WALLET.$WORKER -p x -t $THREADS
echo "✅ Miner started in screen session 'miner'"
echo "📊 Use 'screen -r miner' to view output"
echo "🔓 Detach with CTRL+A then D"