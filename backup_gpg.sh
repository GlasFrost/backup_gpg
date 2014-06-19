#!/usr/bin/env bash

error=0

#Check for enough arguments
if [ $# -ne 3 ]; then
  echo "Backup with encryption using gpg symmetric cipher."
  echo "This software is contributed under the terms of the MIT License."
  echo "Usage: $0 <password file> <source dir> <destination dir>"
  exit 0
fi

#Validate password file
if [ -f "$1" ]; then
  echo "Password file found: $1"
  passwordfile=$1
else
  echo "Oops! Password file not found: $1"
  error=1
fi

#Validate source dir
if [ -d "$2" ]; then
  echo "Source dir found: ${2%/}"
  source=${2%/}
else
  echo "Oops! Source dir not found: ${2%/}"
  error=1
fi

#Validate destination dir
if [ -d "$3" ]; then
  echo "Destination dir found: ${3%/}"
  destination=${3%/}
else
  echo "Oops! Destination dir not found: ${3%/}"
  error=1
fi

#Check for errors
if [ $error -eq 0 ]; then
  #No errors found
  echo "No errors found, assuming everything is ok"
  timest=$(date -d "today" +"%Y-%m-%d_%H-%M-%S")
  filename=$(echo "BACKUP_${2%/}_$timest" | sed -e 's/\//_/g')
  backupfile="$destination/$filename.tar.gz.gpg"
  echo "Attempting to backup to file: $backupfile"
  if tar -c --recursion "$source" | gpg -c --passphrase-fd 3 -o "$backupfile" 3< $passwordfile; then
    echo "Successfully created backup file: $backupfile"
    echo "Attempting to decrypt backup file for safety reasons. Your backup file will stay encrypted in the process and afterwards."
    if gpg -o /dev/null --passphrase-fd 3 -d "$backupfile" 3< $passwordfile; then
      echo "Backup file is decryptable with given password."
      exit 0
    else
      echo "Attempt to decrypt backup file failed!"
      exit 1
    fi
  else
    echo "Something went wrong while creating backup file!"
    exit 1
  fi
else
  #Errors found
  echo "Errors found, aborting"
  exit 1
fi
