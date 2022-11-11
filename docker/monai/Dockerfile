FROM projectmonai/monailabel
# FROM projectmonai/monai

ARG APP_TYPE=radiology
ARG APP_PATH=/opt/monai/app_radiology
ARG APP_PORT=80
ARG APP_TASK_NAME=Task09_Spleen
ARG APP_MODEL=deepedit

# Create the app directory
RUN mkdir $APP_PATH
WORKDIR $APP_PATH

# Download Radiology sample app to local directory
RUN monailabel apps --name $APP_TYPE --download --output .

# Download Task 2 MSD dataset
RUN monailabel datasets --download --name $APP_TASK_NAME --output .

# Start the Radiology app in MONAI label server and start annotating the downloaded images using deepedit model
CMD monailabel start_server -p $APP_PORT --app $APP_TYPE --studies $APP_TASK_NAME/imagesTr --conf models $APP_MODEL
