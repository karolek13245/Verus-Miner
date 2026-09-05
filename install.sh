#!/data/data/com.termux/files/usr/bin/bash
# ═══════════════════════════════════════════════════════
#  VERUS COIN MINER - INSTALLATION SCRIPT v1.0
#  Termux Design by @dendalion.hq 😼
# ═══════════════════════════════════════════════════════

# ─── Colors ──────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GOLD='\033[38;5;220m'
NC='\033[0m'

# ─── Banner ──────────────────────────────────────────
clear
echo -e "${GOLD}"
echo "    ██╗   ██╗███████╗██████╗ ██╗   ██╗███████╗"
echo "    ██║   ██║██╔════╝██╔══██╗██║   ██║██╔════╝"
echo "    ██║   ██║█████╗  ██████╔╝██║   ██║███████╗"
echo "    ╚██╗ ██╔╝██╔══╝  ██╔══██╗██║   ██║╚════██║"
echo "     ╚████╔╝ ███████╗██║  ██║╚██████╔╝███████║"
echo "      ╚═══╝  ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝"
echo -e "${WHITE}"
echo "    ╔══════════════════════════════════════════╗"
echo "    ║     ${GREEN}VERUS COIN MINER INSTALLER${WHITE}      ║"
echo "    ║         ${CYAN}Termux v1.0${WHITE}                   ║"
echo "    ║      ${YELLOW}Jail break'd by @dendalion.hq 😼${WHITE}  ║"
echo "    ╚══════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${YELLOW}[!] This script will install Verus Coin Miner on your device${NC}"
echo -e "${YELLOW}[!] Make sure you have:${NC}"
echo -e "   ${GREEN}✓${NC} ARM64 device (64-bit)"
echo -e "   ${GREEN}✓${NC} 500MB+ free space"
echo -e "   ${GREEN}✓${NC} Stable internet connection"
echo -e "   ${GREEN}✓${NC} Termux from F-Droid"
echo ""
echo -en "${GREEN}Continue? (y/n): ${NC}"
read -p "" confirm

if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo -e "${RED}[!] Installation cancelled.${NC}"
        exit 1
        fi

        # ─── Step 1: Update Packages ────────────────────────
        echo -e "\n${CYAN}[1/6] Updating packages...${NC}"
        pkg update -y && pkg upgrade -y

        # ─── Step 2: Install Dependencies ───────────────────
        echo -e "\n${CYAN}[2/6] Installing dependencies...${NC}"
        pkg install -y \
            git \
                wget \
                    curl \
                        nano \
                            screen \
                                build-essential \
                                    cmake \
                                        automake \
                                            autoconf \
                                                libtool \
                                                    pkg-config \
                                                        libcurl \
                                                            openssl \
                                                                libjansson \
                                                                    python \
                                                                        python-pip 2>/dev/null || true

                                                                        # ─── Step 3: Clone and Build CCminer ────────────────
                                                                        echo -e "\n${CYAN}[3/6] Building CCminer (this may take 5-15 minutes)...${NC}"
                                                                        cd ~

                                                                        if [ -d "ccminer" ]; then
                                                                            echo -e "${YELLOW}[!] ccminer folder exists. Removing...${NC}"
                                                                                rm -rf ccminer
                                                                                fi

                                                                                git clone --single-branch -b ARM https://github.com/monkins1010/ccminer.git
                                                                                cd ccminer
                                                                                chmod +x build-arm.sh
                                                                                ./build-arm.sh

                                                                                # Check if build succeeded
                                                                                if [ ! -f "ccminer" ] && [ ! -f "ccminer-arm" ]; then
                                                                                    echo -e "${RED}[!] Build failed! Please check logs.${NC}"
                                                                                        exit 1
                                                                                        else
                                                                                            # Rename if needed for consistency
                                                                                                if [ -f "ccminer-arm" ] && [ ! -f "ccminer" ]; then
                                                                                                        mv ccminer-arm ccminer
                                                                                                            fi
                                                                                                                echo -e "${GREEN}[+] CCminer built successfully!${NC}"
                                                                                                                fi

                                                                                                                cd ~

                                                                                                                # ─── Step 4: Copy Controller Script ─────────────────
                                                                                                                echo -e "\n${CYAN}[4/6] Installing controller script...${NC}"
                                                                                                                cp verus_miner.sh ~/verus_miner.sh 2>/dev/null || echo ""

                                                                                                                # Create controller if not exists
                                                                                                                if [ ! -f ~/verus_miner.sh ]; then
                                                                                                                    echo -e "${RED}[!] verus_miner.sh not found in current directory.${NC}"
                                                                                                                        echo -e "${YELLOW}Please ensure verus_miner.sh is in the same folder as install.sh${NC}"
                                                                                                                            exit 1
                                                                                                                            fi
                                                                                                                            chmod +x ~/verus_miner.sh

                                                                                                                            # ─── Step 5: Create Startup Script ──────────────────
                                                                                                                            echo -e "\n${CYAN}[5/6] Creating startup script...${NC}"
                                                                                                                            if [ ! -f ~/startup.sh ]; then
                                                                                                                                cat > ~/startup.sh << 'EOF'
                                                                                                                                #!/data/data/com.termux/files/usr/bin/bash
                                                                                                                                POOL="stratum+tcp://na.luckpool.net:3956"
                                                                                                                                WALLET="YOUR_WALLET_ADDRESS_HERE"
                                                                                                                                WORKER="termux_miner"
                                                                                                                                THREADS=4

                                                                                                                                # Check for correct binary name
                                                                                                                                if [ -f ~/ccminer/ccminer ]; then
                                                                                                                                    MINER_BIN="~/ccminer/ccminer"
                                                                                                                                    else
                                                                                                                                        echo "Miner binary not found at ~/ccminer/ccminer"
                                                                                                                                            exit 1
                                                                                                                                            fi

                                                                                                                                            screen -dmS miner $MINER_BIN -a verus -o $POOL -u $WALLET.$WORKER -p x -t $THREADS
                                                                                                                                            echo "Miner started in screen session 'miner'"
                                                                                                                                            EOF
                                                                                                                                                chmod +x ~/startup.sh
                                                                                                                                                fi

                                                                                                                                                # ─── Step 6: Create Boot Script ─────────────────────
                                                                                                                                                echo -e "\n${CYAN}[6/6] Setting up auto-start...${NC}"
                                                                                                                                                mkdir -p ~/.termux/boot
                                                                                                                                                cat > ~/.termux/boot/start_miner.sh << 'EOF'
                                                                                                                                                #!/data/data/com.termux/files/usr/bin/bash
                                                                                                                                                sleep 10
                                                                                                                                                ~/startup.sh
                                                                                                                                                EOF
                                                                                                                                                chmod +x ~/.termux/boot/start_miner.sh

                                                                                                                                                # ─── Completion ──────────────────────────────────────
                                                                                                                                                clear
                                                                                                                                                echo -e "${GREEN}"
                                                                                                                                                echo "    ╔══════════════════════════════════════════╗"
                                                                                                                                                echo "    ║     ✅ INSTALLATION COMPLETE!           ║"
                                                                                                                                                echo "    ║                                         ║"
                                                                                                                                                echo "    ║  🎉 Verus Coin Miner installed!        ║"
                                                                                                                                                echo "    ║                                         ║"
                                                                                                                                                echo "    ║  Next Steps:                           ║"
                                                                                                                                                echo "    ║  1. Edit wallet address:               ║"
                                                                                                                                                echo "    ║     ${YELLOW}nano ~/startup.sh${GREEN}              ║"
                                                                                                                                                echo "    ║  2. Start mining:                      ║"
                                                                                                                                                echo "    ║     ${YELLOW}./verus_miner.sh${GREEN}              ║"
                                                                                                                                                echo "    ║                                         ║"
                                                                                                                                                echo "    ║  ${YELLOW}Jail break'd by @dendalion.hq 😼${GREEN}   ║"
                                                                                                                                                echo "    ╚══════════════════════════════════════════╝"
                                                                                                                                                echo -e "${NC}"

                                                                                                                                                echo -e "${YELLOW}───────────────────────────────────────────────────────${NC}"
                                                                                                                                                echo -e "Quick Commands:"
                                                                                                                                                echo -e "  ${GREEN}./verus_miner.sh${NC}    - Launch controller"
                                                                                                                                                echo -e "  ${GREEN}nano ~/startup.sh${NC}   - Edit config"
                                                                                                                                                echo -e "  ${GREEN}screen -r miner${NC}     - View mining output"
                                                                                                                                                echo -e "  ${GREEN}CTRL+A + D${NC}          - Detach from screen"
                                                                                                                                                echo -e "${YELLOW}───────────────────────────────────────────────────────${NC}"