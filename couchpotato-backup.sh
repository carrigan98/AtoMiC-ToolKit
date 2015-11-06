#!/bin/bash
# Script Name: AtoMiC CouchPotato Backup Script
# Author: htpcBeginner
# Publisher: http://www.htpcBeginner.com
# License: MIT License (refer to README.md for more details)
#

# DO NOT EDIT ANYTHING UNLESS YOU KNOW WHAT YOU ARE DOING.
YELLOW='\e[93m'
RED='\e[91m'
ENDCOLOR='\033[0m'
CYAN='\e[96m'
GREEN='\e[92m'
SCRIPTPATH=$(pwd)

function pause(){
   read -p "$*"
}

clear
echo 
echo -e $RED
echo -e " ┬ ┬┬ ┬┬ ┬ ┬ ┬┌┬┐┌─┐┌─┐┌┐ ┌─┐┌─┐┬┌┐┌┌┐┌┌─┐┬─┐ ┌─┐┌─┐┌┬┐"
echo -e " │││││││││ ├─┤ │ ├─┘│  ├┴┐├┤ │ ┬│││││││├┤ ├┬┘ │  │ ││││"
echo -e " └┴┘└┴┘└┴┘o┴ ┴ ┴ ┴  └─┘└─┘└─┘└─┘┴┘└┘┘└┘└─┘┴└─o└─┘└─┘┴ ┴"
echo -e $CYAN
echo -e "                __  ___             "
echo -e "  /\ |_ _ |\/|./     | _  _ ||_/.|_ "
echo -e " /--\|_(_)|  ||\__   |(_)(_)|| \||_ "
echo
echo -e $GREEN'AtoMiC CouchPotato Backup Script'$ENDCOLOR
echo 
echo -e $YELLOW'--->CouchPotato backup will start soon. Please read the following carefully.'$ENDCOLOR

echo -e '1. The script has been confirmed to work on Ubuntu variants, Mint, and Ubuntu Server.'
echo -e '2. While several testing runs identified no known issues, '$CYAN'www.htpcBeginner.com'$ENDCOLOR' or the authors cannot be held accountable for any problems that might occur due to the script.'
echo -e '3. If you did not run this script with sudo, you maybe asked for your root password during installation.'
echo -e '4. Best used to backup CouchPotato installed using AtoMiC ToolKit or '$CYAN'www.htpcBeginner.com'$ENDCOLOR' guides.'

echo
sleep 10

echo -n 'Type the username of the user you run CouchPotato as and press [ENTER]. Typically, this is your system login name (IMPORTANT! Ensure correct spelling and case): '
read UNAME

if [ ! -d "/home/$UNAME" ] || [ -z "$UNAME" ]; then
	echo -e $RED'Bummer! You may not have entered your username correctly. Exiting now. Please rerun script.'$ENDCOLOR
	echo
	pause 'Press [Enter] key to continue...'
	cd $SCRIPTPATH
	sudo ./setup.sh
	exit 0
fi
UGROUP=($(id -gn $UNAME))

echo
sleep 1

echo -e $YELLOW'--->Creating a list of files to backup...'$ENDCOLOR
cd $SCRIPTPATH
cp couchpotato-backup-files cp-backup-files
sudo sed -i 's/UNAME/'$UNAME'/g' couchpotato-backup-files  || { echo -e $RED'Replacing username in backup list failed.'$ENDCOLOR ; exit 1; }

echo
sleep 1

echo -e $YELLOW'--->Backing up files...'$ENDCOLOR
BFN=couchpotato_`date '+%m-%d-%Y_%H-%M'`
tar -zcvf $BFN.tar.gz --files-from cp-backup-files
echo -e "Following files were backed up:"
cat cp-backup-files
rm cp-backup-files

echo
sleep 1
echo -e $YELLOW'--->Moving backup file to '$CYAN'/home/$UNAME/'$BFN'.tar.gz...'$ENDCOLOR
sudo chown $UNAME:$UGROUP $BFN.tar.gz
sudo chmod 755 $BFN.tar.gz
mv $BFN.tar.gz /home/$UNAME/

sleep 1

echo
echo -e $GREEN'--->All done. '$ENDCOLOR
echo -e 'CouchPotato files backed up. You can use the restore utility to restore it on a new computer.'
echo
echo -e $YELLOW'If this script worked for you, please visit '$CYAN'http://www.htpcBeginner.com'$YELLOW' and like/follow us.'$ENDCOLOR
echo -e $YELLOW'Thank you for using the AtoMiC CouchPotato Backup script from www.htpcBeginner.com.'$ENDCOLOR 
echo

pause 'Press [Enter] key to continue...'

cd $SCRIPTPATH
sudo ./setup.sh
exit 0



