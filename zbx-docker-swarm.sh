#!/usr/bin/env bash

DOCKER_SOCKET=/var/run/docker.sock

request() {
  local url="$1"
  curl -qqs --unix-socket "$DOCKER_SOCKET" "http://localhost/${url}"
}

discovery_services() {
  request services
}

discovery_nodes() {
  request nodes
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  case "$1" in
    discovery|discover)
      case "$2" in
        services|nodes)
          request "$2"
          ;;
        *)
          echo "Unknown discovery action: $2" >&2
          exit 2
      esac
      ;;
    info)
      request swarm
      ;;
    nodes|services|tasks)
      request "$1"
      ;;
  esac
fi
