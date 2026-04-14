#!/bin/bash

# Fungsi untuk membersihkan port
cleanup_ports() {
    echo "Membersihkan port 5500 dan 3000..."
    kill -9 $(lsof -t -i:5500) 2>/dev/null
    kill -9 $(lsof -t -i:3000) 2>/dev/null
}

cleanup_ports

echo "-----------------------------------"
echo "Menjalankan SmartBee dengan AUTO-WATCHER"
echo "-----------------------------------"
echo "Perubahan kode akan langsung ter-update di browser!"
echo "-----------------------------------"

node dev_watch.js
