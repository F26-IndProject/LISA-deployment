# LISA Deployment Guide

## Network Configuration

**Recommended subnet:** `192.168.100.0/24`  
**Server IP:** `192.168.100.10`

If your network scheme is different, update only the `SERVER_IP` value in the `.env` file.

---

## On the LISA Server

### 1. Install Docker

```bash
# Install Docker the official way (the version in Ubuntu's repos is outdated)
curl -fsSL https://get.docker.com | sudo sh

# Add yourself to the docker group so you don't need sudo for every command
sudo usermod -aG docker $USER

# Install Docker Compose
sudo apt install -y docker-compose-plugin

# Verify installation
docker compose version
```

> **Note:** Log out and back in after adding yourself to the docker group for the changes to take effect.

---

### 2. Clone the LISA Deployment Repository

```bash
git clone https://github.com/F26-IndProject/LISA-deployment.git
cd LISA-deployment
```

> Stay in this directory — it contains the `docker-compose.yml` and `.env` files.

---

### 3. Configure the Environment File

Fill in your values in the `.env` file:

```bash
nano .env
```

---

### 4. Clone the Backend and Frontend Repositories

```bash
git clone https://github.com/F26-IndProject/backend.git
git clone https://github.com/F26-IndProject/frontend.git
```

---

### 5. Start Docker Compose

```bash
docker compose up -d
```

---

### 6. Restore the Database Schema

```bash
docker exec -i lisa_postgres_quick psql -U $POSTGRES_USER -d $POSTGRES_DB < lisa_schema.sql
```

---

### 7. Load the Seed Data

```bash
docker exec -i lisa_postgres_quick psql -U $POSTGRES_USER -d $POSTGRES_DB < lisa_seed.sql
```

---

### 8. Start the Frontend

Open a new terminal and make sure you're in the LISA-deployment directory and run:

```bash
cd frontend/frontend
npm install
npm run dev
```

The frontend will be available at `http://localhost:3000`.
