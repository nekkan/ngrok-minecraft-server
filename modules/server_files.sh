#!/bin/bash

function accept_eula() {
  echo "eula=true" >> eula.txt
}

function enable_native_transport() {
  echo "use-native-transport=true" >> server.properties
}

function get_jar_url() {
  # Check if the version was provided.
  if [ -z "$2" ]; then
    echo "ERROR: The server version was not provided."
    exit 1
  fi

  # Check the JAR type for this Minecraft server.
  if [ -n "$1" ]; then
    case "$1" in
      spigot) echo "https://cdn.getbukkit.org/spigot/spigot-$2.jar";;
      *)
        echo "ERROR: An invalid JAR type was provided."
        exit 1;;
    esac
  else
    echo "ERROR: Could not find the JAR type for the Minecraft server installation."
    exit 1
  fi
}

function download_server_jar() {
  # Check if the version was provided.
  if [ -z "$2" ]; then
    echo "ERROR: The server version was not provided."
    exit 1
  fi

  # Check the JAR type for this Minecraft server.
  if [ -z "$1" ]; then
    echo "ERROR: The JAR type was not provided."
    exit 1
  fi

  wget "$(get_jar_url "$1" "$2")"
}
