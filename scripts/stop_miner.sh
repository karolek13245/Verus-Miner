#!/data/data/com.termux/files/usr/bin/bash
# ═══════════════════════════════════════════════════════
#  STOP MINER SCRIPT
#  Termux Design by @dendalion.hq 😼
# ═══════════════════════════════════════════════════════

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}[*] Stopping Verus Coin Miner...${NC}"

if screen -ls 2>/dev/null | grep -q "miner"; then
    screen -XS miner quit
    sleep 1
    echo -e "${GREEN}[+] Miner stopped successfully!${NC}"
else
    echo -e "${RED}[!] No miner is currently running.${NC}"
fi