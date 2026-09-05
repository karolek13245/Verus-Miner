#!/data/data/com.termux/files/usr/bin/bash
# ═══════════════════════════════════════════════════════
#  START MINER SCRIPT
#  Termux Design by @dendalion.hq 😼
# ═══════════════════════════════════════════════════════

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}[*] Starting Verus Coin Miner...${NC}"

if screen -ls 2>/dev/null | grep -q "miner"; then
    echo -e "${RED}[!] Miner is already running!${NC}"
    echo -e "${YELLOW}Use 'screen -r miner' to view output${NC}"
else
    if [ -f ~/startup.sh ]; then
        ~/startup.sh
        sleep 2
        echo -e "${GREEN}[+] Miner started successfully!${NC}"
        echo -e "${YELLOW}View output: screen -r miner${NC}"
    else
        echo -e "${RED}[!] Config file not found!${NC}"
        echo -e "${YELLOW}Run: cp config/example_config.sh ~/startup.sh${NC}"
        echo -e "${YELLOW}Then edit: nano ~/startup.sh${NC}"
    fi
fi