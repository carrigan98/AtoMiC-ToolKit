#!/bin/bash
# Script Name: AtoMiC MythTV Installer
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
echo -e $GREEN'AtoMiC MythTV Installer Script'$ENDCOLOR
echo 
echo -e $YELLOW'--->MythTV installation will start soon. Please read the following carefully.'$ENDCOLOR

echo -e '1. The script has been confirmed to work on Ubuntu variants, Mint, and Ubuntu Server.'
echo -e '2. While several testing runs identified no known issues, '$CYAN'www.htpcBeginner.com'$ENDCOLOR' or the authors cannot be held accountable for any problems that might occur due to the script.'
echo -e '3. If you did not run this script with sudo, you maybe asked for your root password during installation.'
echo -e '4. By proceeding you authorize this script to install any relevant packages required to install and configure MythTV.'
echo -e '5. Best used on a clean system (with no previous CouchPotato install) or after complete removal of previous MythTV installation.'

echo
sleep 10

echo -n 'Type the username of the user you want to run CouchPotato as and press [ENTER]. Typically, this is your system login name (IMPORTANT! Ensure correct spelling and case): '
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

echo -e $YELLOW'--->Refreshing packages list...'$ENDCOLOR
sudo apt-get update

echo
sleep 1

echo -e $YELLOW'--->Installing prerequisites...'$ENDCOLOR
sudo apt-get -y install \
    git-core build-essential ccache yasm libqt4-dev libqtwebkit-dev libqt4-opengl-dev \
    libdvdnav-dev libfreetype6-dev libavc1394-dev libiec61883-dev liblircclient-dev \
    libxinerama-dev libxxf86vm-dev libcrystalhd-dev libxvmc-dev libxext-dev libimlib2-dev \
    libasound2-dev libmp3lame-dev libvorbis-dev libdts-dev lsb-release libpulse-dev \
    libxrandr-dev libfftw3-dev libva-dev libvdpau-dev libudev-dev libclass-dbi-perl \
    libnet-upnp-perl libio-socket-inet6-perl libdbd-mysql-perl libjson-perl libwww-perl \
    python-oauth python-lxml python-mysqldb python-pycurl python-urlgrabber libgl1-mesa-dev \
    libdvdread-dev fftw-dev libvorbis-dev libflac-dev libmad0-dev libcdaudio-dev libcdio-dev \
    libcdparanoia-dev libsdl1.2-dev libfaad-dev libexif-dev libtiff4-dev libxv-dev libtag1-dev \
    libvisual-0.4-dev libmysqlclient-dev libdate-manip-perl libxml-simple-perl libimage-size-perl \
    libdatetime-format-iso8601-perl libsoap-lite-perl libx264-dev libvpx-dev libavahi-compat-libdnssd-dev \
    libssl-dev libcdio-cdda-dev libcdio-paranoia-dev libxml2-dev libass-dev libcec-dev uuid-dev \
    libxml-xpath-perl autoconf gdb mysql-server ntp libicu48 apache2-mpm-prefork php5 php5-mysql libhttp-date-perl
