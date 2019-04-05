#! /bin/sh
echo "---------------------------------------------"
echo "Installing Shinobi"
echo '*Note : Default install location is "/shinobi"'
installLocation="/"
cd $installLocation
echo "Opening Install Location : \"$installLocation\""
if [ ! -d "shinobi/camera.js" ]; then
    # Check OS
    OSTYPE="$(uname -s)"
        # Check if Git is needed
        if [ ! -x "$(command -v git)" ]; then
            # Check if Ubuntu
            if [ -x "$(command -v apt)" ]; then
                sudo apt update
                sudo apt install git -y
            fi
            # Check if Cent OS
            if [ -x "$(command -v yum)" ]; then
                sudo yum update
                sudo yum install git -y
            fi
        fi
        # Check if wget is needed
        if [ ! -x "$(command -v wget)" ]; then
            # Check if Ubuntu
            if [ -x "$(command -v apt)" ]; then
                sudo apt install wget -y
            fi
            # Check if Cent OS
            if [ -x "$(command -v yum)" ]; then
                sudo yum install wget -y
            fi
        fi
    echo "*--------------------**---------------------*"
    echo "Installing Shinobi"
    echo "---------------------------------------------"
        productName="Shinobi Community Editon (CE)"
        theRepo='CE'
        theBranch='master'

    # Download from Git repository
    gitURL="https://gitlab.com/Shinobi-Systems/Shinobi$theRepo"
    sudo git clone $gitURL.git -b $theBranch shinobi
    # Enter Shinobi folder "/shinobi"
    cd shinobi
    cp /installation/ubuntu.sh /shinobi/INSTALL -f && cp /installation/start.sh /shinobi/INSTALL -f
    gitVersionNumber=$(git rev-parse HEAD)
    theDateRightNow=$(date)
    # write the version.json file for the main app to use
    sudo touch version.json
    sudo chmod 777 version.json
    sudo echo '{"Product" : "'"$productName"'" , "Branch" : "'"$theBranch"'" , "Version" : "'"$gitVersionNumber"'" , "Date" : "'"$theDateRightNow"'" , "Repository" : "'"$gitURL"'"}' > version.json
    echo "-------------------------------------"
    echo "---------- Shinobi Systems ----------"
    echo "Repository : $gitURL"
    echo "Product : $productName"
    echo "Branch : $theBranch"
    echo "Version : $gitVersionNumber"
    echo "Date : $theDateRightNow"
    echo "-------------------------------------"
    echo "-------------------------------------"
else
    echo "!-----------------------------------!"
    echo "Shinobi already downloaded."
    cd shinobi
fi
# start the installer in the main app (or start shinobi if already installed)
echo "*-----------------------------------*"
sudo chmod +x INSTALL/start.sh
sudo INSTALL/start.sh
