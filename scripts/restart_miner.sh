#!/data/data/com.termux/files/usr/bin/bash
# ═══════════════════════════════════════════════════════
#  RESTART MINER SCRIPT
#  Termux Design by @dendalion.hq 😼
# ═══════════════════════════════════════════════════════

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}[*] Restarting Verus Coin Miner...${NC}"

# Stop miner
if screen -ls 2>/dev/null | grep -q "miner"; then
    screen -XS miner quit
    sleep 1
    echo -e "${GREEN}[+] Miner stopped${NC}"
fi

# Start miner
if [ -f ~/startup.sh ]; then
    ~/startup.sh
    sleep 2
    echo -e "${GREEN}[+] Miner restarted successfully!${NC}"
else
    echo -e "${RED}[!] Config file not found!${NC}"
    echo -e "${YELLOW}Run: cp config/example_config.sh ~/startup.sh${NC}"
fi