#!/usr/bin/env bash
#
# AI Starter Kit - Automated Setup Script
#
# This script automates the entire setup process after cloning the repository.
# It handles prerequisites, Convex initialization, environment configuration,
# and starts the development server.
#
# Usage:
#   ./setup.sh
#   # or
#   bash setup.sh
#
# Requirements:
#   - Node.js 18 or later
#   - npm (for installing pnpm if needed)
#   - Internet connection (for Convex cloud services)
#
# Works on: macOS, Linux, Windows (Git Bash/WSL)
#

set -e  # Exit on error

# =============================================================================
# Colors and Formatting
# =============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# =============================================================================
# Helper Functions
# =============================================================================

print_banner() {
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}  ${BOLD}AI Starter Kit - Automated Setup${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

print_step() {
    echo ""
    echo -e "${BLUE}▶${NC} ${BOLD}$1${NC}"
}

print_success() {
    echo -e "  ${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "  ${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "  ${RED}✗${NC} $1"
}

print_info() {
    echo -e "  ${CYAN}ℹ${NC} $1"
}

# Check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# =============================================================================
# Prerequisites Check
# =============================================================================

check_prerequisites() {
    print_step "Checking prerequisites..."

    local all_ok=true

    # Check Node.js
    if command_exists node; then
        node_version=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
        if [ "$node_version" -ge 18 ]; then
            print_success "Node.js $(node -v) found"
        else
            print_error "Node.js 18+ required. Current version: $(node -v)"
            print_info "Download from: https://nodejs.org/"
            all_ok=false
        fi
    else
        print_error "Node.js not found"
        print_info "Download from: https://nodejs.org/"
        all_ok=false
    fi

    # Check npm (needed to install pnpm if missing)
    if ! command_exists npm; then
        print_error "npm not found (should come with Node.js)"
        all_ok=false
    fi

    # Check pnpm (auto-install if missing)
    if command_exists pnpm; then
        print_success "pnpm $(pnpm -v) found"
    else
        print_warning "pnpm not found - installing..."
        if npm install -g pnpm; then
            print_success "pnpm installed successfully"
        else
            print_error "Failed to install pnpm"
            print_info "Try manually: npm install -g pnpm"
            all_ok=false
        fi
    fi

    # Check openssl (optional, with fallback)
    if command_exists openssl; then
        print_success "openssl found"
        USE_NODE_CRYPTO=false
    else
        print_warning "openssl not found - will use Node.js crypto instead"
        USE_NODE_CRYPTO=true
    fi

    # Exit if critical prerequisites are missing
    if [ "$all_ok" = false ]; then
        echo ""
        print_error "Prerequisites check failed. Please install the missing requirements and try again."
        exit 1
    fi

    print_success "All prerequisites satisfied!"
}

# =============================================================================
# Install Dependencies
# =============================================================================

install_dependencies() {
    print_step "Installing dependencies..."

    if [ -d "node_modules" ] && [ -f "pnpm-lock.yaml" ]; then
        print_info "node_modules exists, checking if up to date..."
    fi

    if pnpm install; then
        print_success "Dependencies installed successfully"
    else
        print_error "Failed to install dependencies"
        print_info "Try running: pnpm install --force"
        exit 1
    fi
}

# =============================================================================
# Convex Setup (Guided)
# =============================================================================

setup_convex() {
    print_step "Setting up Convex..."

    # Check if already set up
    if [ -f ".env.local" ] && grep -q "NEXT_PUBLIC_CONVEX_URL" .env.local; then
        print_warning ".env.local already exists with Convex URL"
        read -p "  Do you want to skip Convex initialization? (y/N): " skip_convex
        if [[ "$skip_convex" =~ ^[Yy]$ ]]; then
            print_info "Skipping Convex initialization..."
            return 0
        fi
    fi

    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}  ${BOLD}CONVEX SETUP - Interactive Step Required${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "  A browser window will open for Convex authentication."
    echo "  Please:"
    echo ""
    echo "    1. Log in or create a Convex account (it's free!)"
    echo "    2. Create a new project (or select an existing one)"
    echo "    3. Wait for the terminal to show 'Convex functions ready!'"
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    read -p "  Press Enter to start Convex setup..."
    echo ""

    # Run convex dev until it succeeds (creates .env.local)
    print_info "Starting Convex initialization..."
    echo ""

    if npx convex dev --until-success; then
        echo ""
        print_success "Convex initialized successfully!"
    else
        echo ""
        print_error "Convex initialization failed"
        print_info "Try running: npx convex dev"
        exit 1
    fi

    # Verify .env.local was created
    if [ ! -f ".env.local" ]; then
        print_error ".env.local was not created. Convex setup may have failed."
        print_info "Try running: npx convex dev"
        exit 1
    fi

    if ! grep -q "NEXT_PUBLIC_CONVEX_URL" .env.local; then
        print_error "NEXT_PUBLIC_CONVEX_URL not found in .env.local"
        print_info "Convex setup may have failed. Try running: npx convex dev"
        exit 1
    fi

    print_success "Convex setup complete!"
}

# =============================================================================
# Configure Environment
# =============================================================================

configure_environment() {
    print_step "Configuring environment..."

    # Extract deployment name from NEXT_PUBLIC_CONVEX_URL
    CONVEX_URL=$(grep "NEXT_PUBLIC_CONVEX_URL" .env.local | cut -d'=' -f2)

    if [ -z "$CONVEX_URL" ]; then
        print_error "Could not find NEXT_PUBLIC_CONVEX_URL in .env.local"
        exit 1
    fi

    # Extract deployment name (e.g., "shiny-platypus-495" from "https://shiny-platypus-495.convex.cloud")
    DEPLOYMENT_NAME=$(echo "$CONVEX_URL" | sed 's|https://||' | sed 's|\.convex\.cloud||')
    CONVEX_SITE_URL="https://${DEPLOYMENT_NAME}.convex.site"

    print_info "Detected deployment: $DEPLOYMENT_NAME"

    # Add NEXT_PUBLIC_CONVEX_SITE_URL to .env.local if not already set
    if grep -q "NEXT_PUBLIC_CONVEX_SITE_URL" .env.local; then
        print_warning "NEXT_PUBLIC_CONVEX_SITE_URL already set in .env.local"
    else
        echo "" >> .env.local
        echo "NEXT_PUBLIC_CONVEX_SITE_URL=${CONVEX_SITE_URL}" >> .env.local
        print_success "Added NEXT_PUBLIC_CONVEX_SITE_URL to .env.local"
    fi

    # Generate and set BETTER_AUTH_SECRET
    if npx convex env list 2>/dev/null | grep -q "BETTER_AUTH_SECRET"; then
        print_warning "BETTER_AUTH_SECRET already set in Convex"
    else
        print_info "Generating auth secret..."

        if [ "$USE_NODE_CRYPTO" = true ]; then
            # Fallback to Node.js crypto
            SECRET=$(node -e "console.log(require('crypto').randomBytes(32).toString('base64'))")
        else
            # Use openssl
            SECRET=$(openssl rand -base64 32)
        fi

        if npx convex env set BETTER_AUTH_SECRET "$SECRET"; then
            print_success "Set BETTER_AUTH_SECRET in Convex"
        else
            print_error "Failed to set BETTER_AUTH_SECRET"
            print_info "Try manually: npx convex env set BETTER_AUTH_SECRET \$(openssl rand -base64 32)"
        fi
    fi

    # Set SITE_URL
    if npx convex env list 2>/dev/null | grep -q "SITE_URL"; then
        print_warning "SITE_URL already set in Convex"
    else
        if npx convex env set SITE_URL "http://localhost:3000"; then
            print_success "Set SITE_URL in Convex"
        else
            print_error "Failed to set SITE_URL"
            print_info "Try manually: npx convex env set SITE_URL http://localhost:3000"
        fi
    fi

    print_success "Environment configured!"
}

# =============================================================================
# Start Dev Server
# =============================================================================

start_dev_server() {
    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}  ${BOLD}Setup Complete!${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "  Your development environment is ready!"
    echo ""
    echo "  ${BOLD}Starting development servers...${NC}"
    echo ""
    echo "    Frontend:         http://localhost:3000"
    echo "    Convex Dashboard: npx convex dashboard"
    echo ""
    echo "  ${BOLD}Next steps:${NC}"
    echo "    1. Open http://localhost:3000 in your browser"
    echo "    2. Create an account at /signup"
    echo "    3. Start building!"
    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    # Start the dev server
    exec pnpm run dev
}

# =============================================================================
# Main
# =============================================================================

main() {
    print_banner
    check_prerequisites
    install_dependencies
    setup_convex
    configure_environment
    start_dev_server
}

# Run main function
main "$@"
