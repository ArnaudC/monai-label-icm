#!/bin/bash
# Requires 'docker', 'docker-compose', 'dcmtk'. Usage: './start.sh' to list all commands and './start.sh init' to run the monai-label server.
set -eox pipefail

help() {
    set +x
    echo "Usage : sh start.sh [argument]"
    echo ""
    echo " init            Initialize the project from scratch."
    echo " bash            Run a bash shell in monai label server."
    echo " images          Rebuild docker images."
    echo " send            Send a test session to orthanc."
}

init() {
    start
}

images() {
    docker-compose build --no-cache monai-docker
}

start() {
    docker-compose down
    docker-compose up -d
    echo "Server started at http://localhost:$MONAI_LABEL_PORT"
    echo "Start annotating data at http://localhost:$MONAI_LABEL_PORT/ohif"
    logs
}

stop() {
    docker-compose down
}

restart() {
    stop
    start
}

logs() {
    docker-compose logs -ft monai-docker
}

bash() {
    docker-compose exec monai-docker bash
}

send() {
    storescu +r +sd -aec ORTANC -xf /etc/dcmtk/storescu.cfg Default localhost $ORTHANC_DICOM_SCP_RECEIVER "$ORTHANC_TEST_SESSION_PATH"
}

main() {
    if [ $# -eq 0 ]; then
        help
        exit 1
    fi

    if [ ! -f .env ]; then
        echo ".env not found : cp .env.tpl .env"
        cp .env.tpl .env
    fi
    source ./.env

    cmd="$1 ${@:2}" # $1 is the command and ${@:2} is the list of arguments
    $cmd
}

# Main entry point
main "$@"
