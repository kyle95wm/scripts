#!/bin/bash

echo
echo

echo "To encrypt a file:"

echo "openssl enc -aes-256-cbc -e -in FILE-TO-ENCRYPT -out FINALFILE"

echo
echo "To decrypt a file:"

echo "openssl enc -aes-256-cbc -d -in FILE-TO-DECRYPT -out FINALFILE"
