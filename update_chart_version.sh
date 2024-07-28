#!/bin/bash

# Usage: ./update_chart_version.sh /path/to/chart release_type

CHART_PATH=$1
RELEASE_TYPE=$2

if [ -z "$CHART_PATH" ] || [ -z "$RELEASE_TYPE" ]; then
  echo "Usage: $0 /path/to/chart release_type"
  echo "release_type: patch, minor, major"
  exit 1
fi

if ! command -v yq &> /dev/null
then
  echo "yq could not be found, please install yq"
  exit 1
fi

if ! command -v helm &> /dev/null
then
  echo "Helm could not be found, please install Helm"
  exit 1
fi

echo "Reading current version from $CHART_PATH/Chart.yaml..."

# Extract the current version
CURRENT_VERSION=$(yq eval '.version' "$CHART_PATH/Chart.yaml")
echo "Current version: $CURRENT_VERSION"

# Split the version into major, minor, patch
IFS='.' read -r -a VERSION_PARTS <<< "$CURRENT_VERSION"

MAJOR=${VERSION_PARTS[0]}
MINOR=${VERSION_PARTS[1]}
PATCH=${VERSION_PARTS[2]}

echo "Current version components: Major: $MAJOR, Minor: $MINOR, Patch: $PATCH"

# Increment the version based on the release type
case $RELEASE_TYPE in
  patch)
    PATCH=$((PATCH + 1))
    echo "Incrementing patch version..."
    ;;
  minor)
    MINOR=$((MINOR + 1))
    PATCH=0
    echo "Incrementing minor version and resetting patch version to 0..."
    ;;
  major)
    MAJOR=$((MAJOR + 1))
    MINOR=0
    PATCH=0
    echo "Incrementing major version and resetting minor and patch versions to 0..."
    ;;
  *)
    echo "Invalid release type. Use patch, minor, or major."
    exit 1
    ;;
esac

# Construct the new version
NEW_VERSION="$MAJOR.$MINOR.$PATCH"
echo "New version: $NEW_VERSION"

# Update the version in Chart.yaml
echo "Updating version in $CHART_PATH/Chart.yaml..."
yq eval ".version = \"$NEW_VERSION\"" -i "$CHART_PATH/Chart.yaml"

echo "Updated version to $NEW_VERSION in $CHART_PATH/Chart.yaml"

# Package the chart
echo "Packaging the chart..."
helm package "$CHART_PATH" --destination "$REPO_PATH"
echo "Chart packaged."

# Update the Helm repository index
echo "Updating Helm repository index..."
helm repo index .
echo "Helm repository index updated."

echo "All done!"
