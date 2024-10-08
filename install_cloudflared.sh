#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color


clear

# Banner
echo -e "${GREEN}"
echo "######################################"
echo "#                                    #"
echo "#       Script Rebel's Installer     #"
echo "#  Cloudflared Setup Script v1.0     #"
echo "#    Version: 23 May 2024            #"
echo "#                                    #"
echo "######################################"
echo -e "${NC}"

#  OS prompt
echo -e "${BLUE}Which platform are you using?${NC}"
echo "1) Termux"
echo "2) Ubuntu/Kali"
echo "3) Windows (via WSL)"

read -p "Enter your choice (1/2/3): " os_choice


CLOUDFLARED_TERMUX_URL="https://github.com/cloudflare/cloudflared/releases/download/2023.4.1/cloudflared-linux-amd64"
CLOUDFLARED_UBUNTU_URL="https://github.com/cloudflare/cloudflared/releases/download/2023.4.1/cloudflared-linux-amd64.deb"
CLOUDFLARED_WINDOWS_URL="https://github.com/cloudflare/cloudflared/releases/download/2023.4.1/cloudflared-windows-amd64.zip"


show_progress() {
  echo -ne "${GREEN}Processing: ${NC}"
  for i in {1..100}; do
    echo -ne "${BLUE}#"
    sleep 0.05
  done
  echo -ne "${NC}\n"
}


if [ "$os_choice" == "1" ]; then
  echo -e "${GREEN}Downloading and installing cloudflared ...${NC}"
  curl -L $CLOUDFLARED_TERMUX_URL -o cloudflared
  chmod +x cloudflared
  mv cloudflared $PREFIX/bin/

  apt --fix-broken install -y  
  show_progress
elif [ "$os_choice" == "2" ]; then
  echo -e "${GREEN}Downloading and installing cloudflared (23 May 2024) on Ubuntu/Kali...${NC}"
  wget $CLOUDFLARED_UBUNTU_URL -O cloudflared.deb
  sudo dpkg -i cloudflared.deb
  show_progress
elif [ "$os_choice" == "3" ]; then
  echo -e "${GREEN}Downloading and installing cloudflared (23 May 2024) on Windows (via WSL)...${NC}"
  wget $CLOUDFLARED_WINDOWS_URL -O cloudflared.zip
  unzip cloudflared.zip
  mv ./cloudflared.exe /usr/local/bin/
  chmod +x /usr/local/bin/cloudflared.exe
  show_progress
else
  echo -e "${RED}Invalid choice! Please restart the script.${NC}"
  exit 1
fi


echo -e "${GREEN}Cloudflared installation completed!${NC}"


if [ "$os_choice" == "1" ]; then
  echo -e "${BLUE}To use cloudflared on Termux, run:${NC} ${GREEN}cloudflared tunnel --url http://localhost:8080${NC}"
elif [ "$os_choice" == "2" ]; then
  echo -e "${BLUE}To use cloudflared on Ubuntu/Kali, run:${NC} ${GREEN}cloudflared tunnel --url http://localhost:8080${NC}"
elif [ "$os_choice" == "3" ]; then
  echo -e "${BLUE}To use cloudflared on Windows (WSL), run:${NC} ${GREEN}cloudflared.exe tunnel --url http://localhost:8080${NC}"
fi


echo -e "${BLUE}Press Enter to exit...${NC}"
read -p ""
xdg-open "https://www.youtube.com/channel/UCq90dlKp-_nPvYlE-zU3fyg"  # Replace with your actual YouTube URL
exit
