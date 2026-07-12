# LISA Server Deployment Guide

## Prerequisites

- Ubuntu 22.04
- Docker
- Docker Compose
- Node.js (includes npm)

If any of the prerequisites is missing, the `install.sh` will detect it and install it automatically.

---

## On the LISA Server

### 1. Clone the LISA Deployment Repository

```bash
git clone https://github.com/F26-IndProject/LISA-deployment.git
cd LISA-deployment
```

Stay in this directory — it contains the `docker-compose.yml` and `.env` files.

### 2. Configure the Environment File

```bash
nano .env
```

### 3. Run the Installation Script

```bash
chmod +x install.sh && sudo ./install.sh
```

The script will:

- Check and install missing prerequisites
- Clone the backend and frontend repositories
- Start Docker Compose
- Restore the database schema and seed data
- Set up the SMB share directory at `/srv/samba/share` with sample files
- Start the frontend

To test the SMB share from a Windows agent:

```powershell
dir \\LISA_SERVER_IP\share
```

From a Linux agent:

```bash
smbclient //LISA_SERVER_IP/share -N -c "ls"
```

This terminal will be taken by npm. Do not stop it — open another terminal and continue working.

The frontend will be available at `http://localhost:3000`.

---

## Installing Prerequisites (This is just reference. Installation has been automated with the script.) So you don't need to run this commands if installation was successful

### Docker and Docker Compose

Install dependencies:

```bash
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
```

Add Docker's GPG key, official repository and update system repository:

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Update the package list:

```bash
sudo apt update
```

Install Docker:

```bash
sudo apt install docker-ce docker-ce-cli containerd.io -y
docker compose version
```

### Node.js and npm

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
node -v
npm -v
```
