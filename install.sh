#!/bin/bash

# ============================================
# PROJECT Z-AURA - ULTIMATE INSTALLATION SCRIPT
# Dragon Ball Super - Ultra Instinct Edition
# ============================================

# Warna-warna epic
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Cek root
if (( $EUID != 0 )); then
    echo -e "${RED}✘ Error: Jalankan sebagai root (sudo su)${NC}"
    exit 1
fi

# Banner Keren
show_banner() {
    clear
    echo -e "${BLUE}"
    cat << "EOF"
    ╔═══════════════════════════════════════════════════════════════╗
    ║                                                               ║
    ║     ███████╗     █████╗     ██╗   ██╗██████╗  █████╗        ║
    ║     ╚══███╔╝    ██╔══██╗    ██║   ██║██╔══██╗██╔══██╗       ║
    ║       ███╔╝     ███████║    ██║   ██║██████╔╝███████║       ║
    ║      ███╔╝      ██╔══██║    ██║   ██║██╔══██╗██╔══██║       ║
    ║     ███████╗    ██║  ██║    ╚██████╔╝██║  ██║██║  ██║       ║
    ║     ╚══════╝    ╚═╝  ╚═╝     ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝       ║
    ║                                                               ║
    ║              ⚡ ULTRA INSTINCT THEME BY SUIKA v2.0 ⚡                 ║
    ║                                                               ║
    ╚═══════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
    
    echo -e "${PURPLE}┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "${PURPLE}│${NC}  ${CYAN}✦ Pterodactyl Panel Theme - Dragon Ball Super${NC}     ${PURPLE}│${NC}"
    echo -e "${PURPLE}│${NC}  ${WHITE}Premium Glassmorphism + Galactic Aesthetic${NC}        ${PURPLE}│${NC}"
    echo -e "${PURPLE}└─────────────────────────────────────────────────────┘${NC}\n"
}

# Animasi loading
loading() {
    echo -ne "${YELLOW}"
    for i in {1..5}; do
        echo -n "▓"
        sleep 0.2
    done
    echo -ne "${NC}\n"
}

# Backup panel
backup_panel() {
    echo -e "\n${CYAN}⏳ Membuat backup panel...${NC}"
    cd /var/www/
    BACKUP_NAME="pterodactyl-backup-$(date +%Y%m%d-%H%M%S).tar.gz"
    tar -czf "$BACKUP_NAME" pterodactyl
    echo -e "${GREEN}✓ Backup berhasil: $BACKUP_NAME${NC}"
}

# Install theme
install_theme() {
    echo -e "\n${PURPLE}╔════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${NC}        ${WHITE}⚡ MENGINSTAL Z-AURA THEME...${NC}              ${PURPLE}║${NC}"
    echo -e "${PURPLE}╚════════════════════════════════════════════════════╝${NC}\n"
    
    # Backup dulu
    backup_panel
    
    # Cek direktori panel
    if [ ! -d "/var/www/pterodactyl" ]; then
        echo -e "${RED}✘ Pterodactyl panel tidak ditemukan di /var/www/pterodactyl${NC}"
        exit 1
    fi
    
    cd /var/www/pterodactyl
    
    # Download theme
    echo -e "\n${CYAN}📦 Downloading theme files...${NC}"
    loading
    
    # Buat direktori theme
    mkdir -p public/css/components
    mkdir -p public/css/pages
    mkdir -p public/js
    mkdir -p resources/views/partials
    mkdir -p resources/views/admin/servers
    
    # Download semua file dari GitHub raw
    BASE_URL="https://raw.githubusercontent.com/YOUR_USERNAME/pterodactyl-theme-zaura/main"
    
    # Download CSS files
    echo -e "${CYAN}📥 Downloading CSS files...${NC}"
    curl -s "$BASE_URL/public/css/theme.css" -o public/css/theme.css
    curl -s "$BASE_URL/public/css/components/glass-card.css" -o public/css/components/glass-card.css
    curl -s "$BASE_URL/public/css/components/buttons.css" -o public/css/components/buttons.css
    curl -s "$BASE_URL/public/css/components/dragon-ball.css" -o public/css/components/dragon-ball.css
    curl -s "$BASE_URL/public/css/components/terminal.css" -o public/css/components/terminal.css
    curl -s "$BASE_URL/public/css/pages/login.css" -o public/css/pages/login.css
    curl -s "$BASE_URL/public/css/pages/dashboard.css" -o public/css/pages/dashboard.css
    curl -s "$BASE_URL/public/css/pages/console.css" -o public/css/pages/console.css
    
    # Download JS files
    echo -e "${CYAN}📥 Downloading JavaScript files...${NC}"
    curl -s "$BASE_URL/public/js/cosmic-particles.js" -o public/js/cosmic-particles.js
    curl -s "$BASE_URL/public/js/scouter-hud.js" -o public/js/scouter-hud.js
    curl -s "$BASE_URL/public/js/theme-init.js" -o public/js/theme-init.js
    
    # Download View files
    echo -e "${CYAN}📥 Downloading Blade templates...${NC}"
    curl -s "$BASE_URL/resources/views/layouts/admin.blade.php" -o resources/views/layouts/admin.blade.php
    curl -s "$BASE_URL/resources/views/auth/login.blade.php" -o resources/views/auth/login.blade.php
    curl -s "$BASE_URL/resources/views/admin/servers/index.blade.php" -o resources/views/admin/servers/index.blade.php
    curl -s "$BASE_URL/resources/views/admin/servers/console.blade.php" -o resources/views/admin/servers/console.blade.php
    curl -s "$BASE_URL/resources/views/partials/scouter-hud.blade.php" -o resources/views/partials/scouter-hud.blade.php
    curl -s "$BASE_URL/resources/views/partials/cosmic-sidebar.blade.php" -o resources/views/partials/cosmic-sidebar.blade.php
    
    # Install dependencies
    echo -e "\n${CYAN}📦 Installing Node.js dependencies...${NC}"
    
    # Setup NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # Install Node.js 16
    nvm install 16
    nvm use 16
    
    # Install Yarn
    npm install -g yarn
    
    # Install panel dependencies
    yarn install
    
    # Build assets
    echo -e "\n${CYAN}🔨 Building assets...${NC}"
    export NODE_OPTIONS=--openssl-legacy-provider
    yarn build:production || yarn build
    
    # Clear cache
    php artisan view:clear
    php artisan cache:clear
    php artisan config:clear
    php artisan optimize:clear
    
    # Set permissions
    chown -R www-data:www-data /var/www/pterodactyl
    chmod -R 755 /var/www/pterodactyl/storage
    
    echo -e "\n${GREEN}╔════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${NC}        ${WHITE}✨ INSTALASI BERHASIL! ✨${NC}                   ${GREEN}║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}🌌 Z-Aura Theme berhasil diinstall!${NC}"
    echo -e "${WHITE}➜ Akses panelmu di: ${GREEN}https://domain-anda.com${NC}"
    echo -e "${WHITE}➜ Mode Ultra Instinct: ${PURPLE}ACTIVATED${NC}"
    echo ""
    echo -e "${YELLOW}⚠️  Jangan lupa refresh browser dengan Ctrl+F5${NC}"
}

# Menu utama
show_menu() {
    echo -e "\n${CYAN}╔════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}         ${WHITE}PILIH OPSI INSTALASI${NC}              ${CYAN}║${NC}"
    echo -e "${CYAN}╠════════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║${NC}  ${GREEN}[1]${NC} Install Z-Aura Theme Baru            ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${YELLOW}[2]${NC} Restore Backup Panel                 ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${PURPLE}[3]${NC} Repair Panel (Kalau error)          ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}  ${RED}[4]${NC} Keluar                               ${CYAN}║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════╝${NC}"
    echo ""
    read -p "$(echo -e ${WHITE}➜ Masukkan pilihan [1-4]: ${NC})" choice
    
    case $choice in
        1)
            echo -e "\n${YELLOW}⚠️  Warning: Ini akan memodifikasi panel Pterodactyl!${NC}"
            read -p "Lanjutkan instalasi? [y/N]: " confirm
            if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
                install_theme
            else
                echo -e "${RED}Instalasi dibatalkan.${NC}"
                exit 0
            fi
            ;;
        2)
            restore_backup
            ;;
        3)
            repair_panel
            ;;
        4)
            echo -e "\n${GREEN}👋 Sampai jumpa, Space Warrior!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}✘ Pilihan tidak valid!${NC}"
            exit 1
            ;;
    esac
}

# Restore backup
restore_backup() {
    echo -e "\n${YELLOW}⚡ Merestore backup...${NC}"
    
    LATEST_BACKUP=$(ls -t /var/www/pterodactyl-backup-*.tar.gz 2>/dev/null | head -1)
    
    if [ -f "$LATEST_BACKUP" ]; then
        cd /var/www
        rm -rf pterodactyl
        tar -xzf "$LATEST_BACKUP"
        
        cd pterodactyl
        yarn build:production
        php artisan optimize:clear
        
        echo -e "${GREEN}✓ Backup berhasil direstore!${NC}"
    else
        echo -e "${RED}✘ Tidak ada backup ditemukan!${NC}"
    fi
}

# Repair panel
repair_panel() {
    echo -e "\n${YELLOW}🔧 Memperbaiki panel...${NC}"
    
    cd /var/www/pterodactyl
    
    # Rebuild assets
    yarn build:production
    
    # Clear cache
    php artisan view:clear
    php artisan cache:clear
    php artisan config:clear
    php artisan optimize:clear
    
    # Fix permissions
    chown -R www-data:www-data /var/www/pterodactyl
    chmod -R 755 /var/www/pterodactyl/storage
    chmod -R 755 /var/www/pterodactyl/bootstrap/cache
    
    echo -e "${GREEN}✓ Panel berhasil diperbaiki!${NC}"
}

# Run
show_banner
show_menu
