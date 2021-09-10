#!/usr/bin/env bash
# build the docker image

echo "================================================================================================="
echo "This script is only used during development to quickly deploy updates to a Canary/Dev cluster. "
echo "It is not called by the Jenkins. You should also not use it to patch or update a live cluster."
echo "================================================================================================="
echo ""

VERSION=$(uuidgen)
# adding "_dev" to the project to avoid to affect negatively the PROD docker repository
PROJECT=hello-app
REPOSITORY=clm-sl-sli.common.repositories.cloud.sap



# causes the shell to exit if any subcommand or pipeline returns a non-zero status.
set -e

# set debug mode
#set -x


# build the new docker image
#
echo '>>> Building new image'
# Due to a bug in Docker we need to analyse the log to find out if build passed (see https://github.com/dotcloud/docker/issues/1875)
docker build --no-cache=true --rm -t $REPOSITORY/$PROJECT:$VERSION . | tee /tmp/docker_build_result.log
RESULT=$(cat /tmp/docker_build_result.log | tail -n 1)
if [[ "$RESULT" != *Successfully* ]];
then
  exit -1
fi


echo '>>> Push new image'
docker push $REPOSITORY/$PROJECT:$VERSION

# Apply the YAML passed into stdin and replace the version string first
#cat ./yaml/master-controller.yaml | sed "s/$REPOSITORY\/$PROJECT/$REPOSITORY\/$PROJECT:$VERSION/g" | kubectl apply -f -
cat deployment.yaml | sed "s~<image-name>~$REPOSITORY/$PROJECT:$VERSION~g" | kubectl apply -f -
