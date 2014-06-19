backup_gpg
==========

Creates a backup of a directory using tar and encrypts it with gpg using the default symmetric cipher of your configuration. The encrypted backup file is tested if it can be decrypted for data safety reasons. The password for all that has to be in a file. Make sure to "chmod 600" the password file!
