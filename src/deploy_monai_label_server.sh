#!/bin/bash
set -eox pipefail

APP_PATH=/opt/monai/app_radiology

# Create the app directory
mkdir $APP_PATH
cd $APP_PATH

# download Radiology sample app to local directory
monailabel apps --name radiology --download --output .

# download Task 2 MSD dataset
monailabel datasets --download --name Task09_Spleen --output .

# start the Radiology app in MONAI label server
# and start annotating the downloaded images using deepedit model
monailabel start_server --app radiology --studies Task09_Spleen/imagesTr --conf models deepedit
