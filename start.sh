#!/bin/bash
set -e                                   # berhenti kalau ada langkah yang gagal

cd "$(dirname "$0")"                     # selalu kerja dari folder root, dari mana pun script dipanggil

# 0. pastikan Docker hidup
docker info > /dev/null 2>&1 || { echo "Docker belum jalan"; exit 1; }

echo "--- 1. Build image operator (rapid7-dev) ---"
docker build -t rapid7-dev .             # cepat kalau layer sudah di-cache

echo "--- 2. Start service aplikasi (nginx, redis, mysql) ---"
docker compose -f orchestration/docker-compose.yml up -d

echo "--- 3. Start operator ---"
docker compose up -d                     # compose di root

echo "--- 4. Masuk ke operator ---"
docker compose exec operator bash        # pakai NAMA SERVICE, bukan nama container
