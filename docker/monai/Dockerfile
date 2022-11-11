FROM projectmonai/monailabel

# Arguments
ARG MONAI_LABEL_TYPE=radiology
ARG MONAI_LABEL_PATH=/opt/monai/app
ARG MONAI_LABEL_TASK_NAME=Task09_Spleen
ARG MONAI_LABEL_MODEL=deepedit
ARG MONAI_LABEL_STUDIES=Task09_Spleen/imagesTr
ARG MONAI_LABEL_PORT=45681

# Create the app directory
RUN mkdir $MONAI_LABEL_PATH
WORKDIR $MONAI_LABEL_PATH

# Download Radiology sample app to local directory
RUN monailabel apps --name $MONAI_LABEL_TYPE --download --output .

# Download Task 2 MSD dataset
RUN monailabel datasets --download --name $MONAI_LABEL_TASK_NAME --output .

# Start the Radiology app in MONAI label server and start annotating the downloaded images using deepedit model
CMD monailabel start_server -p $MONAI_LABEL_PORT --app $MONAI_LABEL_TYPE --studies $MONAI_LABEL_STUDIES --conf models $MONAI_LABEL_MODEL
