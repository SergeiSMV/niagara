#!/bin/bash

caesar_cipher() {
    echo "$1" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

read -p "Enter text to encrypt: " text
caesar_cipher "$text"