#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true  

bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
				+login anonymous \
				+app_update "${STEAMAPPID}" \
				+quit

cd "${STEAMAPPDIR}"

xmxarg="-Xmx"
xmxarg+="${XMX}"

xmsarg="-Xms"
xmsarg+="${XMS}"

server_ini_file="/home/steam/Zomboid/Server/server.ini"
# Change server configuration
if [ -f $server_ini_file ]
then
    sed -ri "s/^Password=(.*)$/Password=${SERVER_PASSWORD}/" "${server_ini_file}"
    sed -ri "s/^PublicName=(.*)$/PublicName=${SERVER_PUBLIC_NAME}/" "${server_ini_file}"
    sed -ri "s/^PublicDescription=(.*)$/PublicDescription=${SERVER_PUBLIC_DESC}/" "${server_ini_file}"
    sed -ri "s/^RCONPort=([0-9]+)$/RCONPort=${RCON_PORT}/" "${server_ini_file}"
    sed -ri "s/^RCONPassword=(.*)$/RCONPassword=${RCON_PASSWORD}/" "${server_ini_file}"
fi

bash "${STEAMAPPDIR}/start-server.sh "${xmsarg}" "${xmxarg}" -adminpassword "${ADMIN_PASSWORD}" -servername "server""