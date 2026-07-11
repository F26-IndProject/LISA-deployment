#!/bin/bash
# install.sh
# =====================
# LISA Server Setup Script
#
# BEFORE RUNNING:
#   1. Clone the repo:   git clone https://github.com/F26-IndProject/LISA-deployment.git
#   2. Configure .env:   nano .env
#   3. Run this script:  chmod +x install.sh && sudo ./install.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SYS_ARCH=$(dpkg --print-architecture)

echo "=== LISA Server Setup ==="
echo ""

# ── 1. Check and install prerequisites ───────────────────────────────────────
echo "[1/6] Checking prerequisites..."

if which docker >/dev/null 2>&1; then
    echo "Docker already installed — skipping"
else
    echo "Installing Docker..."
    apt install apt-transport-https ca-certificates curl software-properties-common -y
    [ -f /usr/share/keyrings/docker.gpg ] || \
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker.gpg
    UBUNTU_CODENAME=$(lsb_release -cs)
    [ -f /etc/apt/sources.list.d/docker.list ] || \
        echo "deb [arch=${SYS_ARCH} signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu ${UBUNTU_CODENAME} stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt update
    apt install docker-ce docker-ce-cli containerd.io -y
    echo "Docker installed ✓"
fi

if which node >/dev/null 2>&1; then
    echo "Node.js already installed — skipping"
else
    echo "Installing Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
    apt install -y nodejs
    echo "Node.js installed ✓"
fi

# Clear shell binary path cache so newly installed binaries are found
hash -r

echo ""
echo "node: $(node -v)"
echo "npm:  $(npm -v)"
echo "$(docker compose version)"
echo ""

# ── 2. Clone backend and frontend repositories ────────────────────────────────
echo "[2/6] Cloning repositories..."
cd "$SCRIPT_DIR"
[ -d "backend" ] || git clone https://github.com/F26-IndProject/backend.git
[ -d "frontend" ] || git clone https://github.com/F26-IndProject/frontend.git

# ── 3. Start Docker Compose ───────────────────────────────────────────────────
echo "[3/6] Starting Docker Compose..."
docker compose up -d --build

# ── 4. Restore database schema and seed data ──────────────────────────────────
echo "[4/6] Restoring database schema and seed data..."
if [ -f "$SCRIPT_DIR/.env" ]; then
    export $(grep -v '^#' "$SCRIPT_DIR/.env" | xargs -d '\n')
else
    echo "ERROR: .env file not found in $SCRIPT_DIR"
    exit 1
fi

echo "Waiting for PostgreSQL to be ready..."
until docker exec lisa_postgres_quick pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB" >/dev/null 2>&1; do
    echo -n "."
    sleep 1
done
echo " DB is ready."

echo "Restoring schema..."
docker exec -i lisa_postgres_quick psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" < "$SCRIPT_DIR/lisa_schema.sql"

echo "Loading seed data..."
docker exec -i lisa_postgres_quick psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" < "$SCRIPT_DIR/lisa_seed.sql"

echo ""
echo ""

# ── 5. Install frontend dependencies ─────────────────────────────────────────
echo "[5/6] Installing frontend dependencies..."
if [ -d "$SCRIPT_DIR/frontend/frontend" ]; then
    cd "$SCRIPT_DIR/frontend/frontend"
else
    cd "$SCRIPT_DIR/frontend"
fi
npm install

# ── 6. Start frontend ─────────────────────────────────────────────────────────
echo "[6/6] Starting frontend..."
echo "Frontend will be available at: http://localhost:3000"
echo "Press Ctrl+C to stop the frontend and 'npm run dev' to start it again."
echo "Don't close this terminal. open a new one and continue otherwise the frontend will stop"
echo ""
npm run dev
