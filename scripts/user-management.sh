#!/bin/bash

case "$1" in
    "create-user")
        docker-compose exec headscale headscale users create "$2"
        ;;
    "list-users")
        docker-compose exec headscale headscale users list
        ;;
    "register-node")
        docker-compose exec headscale headscale nodes register --user "$2" --key "$3"
        ;;
    "list-nodes")
        docker-compose exec headscale headscale nodes list
        ;;
    "api-key")
        docker-compose exec headscale headscale apikeys create
        ;;
    *)
        echo "Usage: $0 {create-user|list-users|register-node|list-nodes|api-key} [args]"
        echo "Examples:"
        echo "  $0 create-user home-lab"
        echo "  $0 register-node home-lab <nodekey>"
        echo "  $0 api-key"
        ;;
esac