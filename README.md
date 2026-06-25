# LISA Deployment Guide

## Network Configuration

**Recommended subnet:** `192.168.100.0/24`  
**Server IP:** `192.168.100.10`

If your network scheme is different, update only the `SERVER_IP` value in the `.env` file.

---

## Prerequisites

- Docker
- Docker Compose
- Node.js (includes npm)

> See [Installing Prerequisites](#installing-prerequisites) at the bottom of this guide.

---

## On the LISA Server

### 1. Clone the LISA Deployment Repository

```bash
git clone https://github.com/F26-IndProject/LISA-deployment.git
cd LISA-deployment
```

> Stay in this directory — it contains the `docker-compose.yml` and `.env` files.

---

### 2. Configure the Environment File

```bash
nano .env
```

---

### 3. Clone the Backend and Frontend Repositories

```bash
git clone https://github.com/F26-IndProject/backend.git
git clone https://github.com/F26-IndProject/frontend.git
```

---

### 4. Start Docker Compose

```bash
docker compose up -d --build
```

> `--build` is required on the first run to build the backend image.

---

### 5. Restore the Database Schema and Seed Data

First, load the environment variables:

```bash
export $(cat .env | grep -v '#' | xargs)
```

Restore the schema:

```bash
docker exec -i lisa_postgres_quick psql -U $POSTGRES_USER -d $POSTGRES_DB < lisa_schema.sql
```

> You may see the error below during restore — it is harmless:
> ```
> ERROR:  role "lisa" does not exist
> ```

Load the seed data:

```bash
docker exec -i lisa_postgres_quick psql -U $POSTGRES_USER -d $POSTGRES_DB < lisa_seed.sql
```

---

### 6. Start the Frontend

Open a new terminal and run:

```bash
cd LISA-deployment/frontend/frontend
npm install
npm run dev
```

The frontend will be available at `http://<SERVER_IP>:3000`.

---

## Installing Prerequisites

### Docker

```bash
sudo systemctl stop packagekit
curl -fsSL https://get.docker.com | sudo sh
sudo groupadd docker
sudo usermod -aG docker $USER
sudo apt install -y docker-compose-plugin
exit
```

Log back in, then verify:

```bash
docker compose version
```

**Common problems:**

| Problem | Solution |
|---------|----------|
| `E: Could not get lock /var/lib/apt/lists/lock. It is held by process XXXX (packagekitd)` | Run `sudo systemctl stop packagekit` then retry |
| `usermod: group 'docker' does not exist` | Run `sudo groupadd docker` first, then `sudo usermod -aG docker $USER` |

---

### Node.js

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
node -v
npm -v
```

**Common problems:**

| Problem | Solution |
|---------|----------|
| `E: Could not get lock /var/lib/dpkg/lock-frontend` | Run `sudo systemctl stop unattended-upgrades` then retry |
