#!/bin/sh -l

WEAVIATE_VERSION=$1
WEAVIATE_PORT=$2

echo "::group::Starting Weaviate"
echo "  - version [$WEAVIATE_VERSION]"
echo "  - port [$WEAVIATE_PORT]"
echo ""

docker run --name weaviate --publish $WEAVIATE_PORT:$WEAVIATE_PORT --env QUERY_DEFAULTS_LIMIT=25 --env AUTHENTICATION_ANONYMOUS_ACCESS_ENABLED=true --env PERSISTENCE_DATA_PATH='/var/lib/weaviate' --env DEFAULT_VECTORIZER_MODULE='none' --env CLUSTER_HOSTNAME='node1' --detach semitechnologies/weaviate:$WEAVIATE_VERSION

if [ $? -ne 0 ]; then
    echo "Error starting Weaviate in Docker container"
    exit 2
fi

echo "::endgroup::"