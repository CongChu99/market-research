#!/usr/bin/env bash
set -euo pipefail

# market-research installer
# Usage: curl -fsSL https://raw.githubusercontent.com/<user>/market-research/main/install.sh | bash

REPO="https://github.com/CongChu99/market-research.git"
INSTALL_DIR="${HOME}/.market-research"
BIN_LINK="/usr/local/bin/market-research"

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BOLD}Installing market-research...${NC}"
echo ""

# Check git
if ! command -v git &>/dev/null; then
  echo -e "${RED}✗ git is required but not installed.${NC}"
  exit 1
fi

# Clone or update
if [[ -d "${INSTALL_DIR}" ]]; then
  echo -e "  Updating existing installation..."
  cd "${INSTALL_DIR}" && git pull --quiet
else
  echo -e "  Cloning repository..."
  git clone --quiet "${REPO}" "${INSTALL_DIR}"
fi

# Make executable
chmod +x "${INSTALL_DIR}/market-research"

# Link to PATH
if [[ -w "$(dirname "${BIN_LINK}")" ]]; then
  ln -sf "${INSTALL_DIR}/market-research" "${BIN_LINK}"
  echo -e "  ${GREEN}✓${NC} Linked to ${BIN_LINK}"
else
  echo -e "  Linking to ${BIN_LINK} (requires sudo)..."
  sudo ln -sf "${INSTALL_DIR}/market-research" "${BIN_LINK}"
  echo -e "  ${GREEN}✓${NC} Linked to ${BIN_LINK}"
fi

echo ""
echo -e "${GREEN}${BOLD}✓ market-research installed!${NC}"
echo ""
echo -e "Get started:"
echo -e "  ${CYAN}cd your-project${NC}"
echo -e "  ${CYAN}market-research init${NC}"
echo ""
echo -e "Then tell your AI:"
echo -e "  ${CYAN}/market-research \"your product idea\"${NC}"
