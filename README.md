backup_gpg
==========

Creates a backup of a directory using tar and encrypts it with GPG using the default symmetric cipher of your GPG configuration.
The encrypted backup file is tested wether or not it can be decrypted for data safety reasons.
The password for all that has to be in a file. Make sure to "chmod 600" the password file!


Usage
-----

backup_gpg.sh <password file> <source dir> <destination dir>

<password file> is the path to the password file. The first line of the file is used as password (according to GPG's man page)

<source dir> is the path to the directory which you want to make a backup of.

<destination dir> is the path to the directory the backup file will be stored in.


How it works
------------

The script uses tar to compress all the files (and the files in subdirs).
The compressed output is piped to GPG which then encrypts the compressed data with the password given in the password file.
Once encrypted the backup file is being checked wether it can be decrypted or something went wrong.

The final backup file is called "BACKUP_<source path>_<timestamp>.tar.gz.gpg". In <source_path> all slashes (/) have been replaced with underscores (_) for obvious reasons. <timestamp> contains year, month, day, hour, minute and second (in exactly this order) of when the backup started.

DANGER!!!
---------

You need to make sure that NOONE BUT YOU CAN EVER READ THE PASSWORD FILE!

"chmod 600" should do the trick for the most part.

And don't loose the password file if you want to be able to decrypt your data one day! You can print it out or write down the password to be safe.
