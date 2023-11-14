#!/bin/bash

# Source and Destination Artifactory settings
SOURCE_REGISTRY="source.artifactory.domain"
DESTINATION_REGISTRY="destination.artifactory.domain"
SOURCE_USER="source-username"
SOURCE_PASSWORD="source-password"
DEST_USER="destination-username"
DEST_PASSWORD="destination-password"

# List of image names and tags
declare -a images=("image1:tag1" "image2:tag2" "image3:tag3")

# Log in to the source Artifactory (Docker registry)
docker login $SOURCE_REGISTRY -u $SOURCE_USER -p $SOURCE_PASSWORD

# Log in to the destination Artifactory (Docker registry)
docker login $DESTINATION_REGISTRY -u $DEST_USER -p $DEST_PASSWORD

# Loop through each image and process
for image in "${images[@]}"; do
    # Pull the Docker image from the source registry
    docker pull $SOURCE_REGISTRY/$image

    # Tag the image for the destination registry
    docker tag $SOURCE_REGISTRY/$image $DESTINATION_REGISTRY/$image

    # Push the image to the destination registry
    docker push $DESTINATION_REGISTRY/$image
done
