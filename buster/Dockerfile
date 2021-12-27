###########################################################
# Dockerfile that builds a Project Zomboid Gameserver
###########################################################
FROM cm2network/steamcmd:root

ENV STEAMAPPID 108600
ENV STEAMAPP projectzomboid
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV DLURL https://raw.githubusercontent.com/matm616/ProjectZomboidServer

# Create autoupdate config
# Add entry script
# Remove packages and tidy up
RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget=1.20.1-1.1 \
		ca-certificates=20200601~deb10u2 \
		lib32z1=1:1.2.11.dfsg-1 \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& wget --max-redirect=30 "${DLURL}/master/etc/entry.sh" -O "${HOMEDIR}/entry.sh" \
	&& { \
		echo '@ShutdownOnFailedCommand 1'; \
		echo '@NoPromptForPassword 1'; \
		echo 'force_install_dir '"${STEAMAPPDIR}"''; \
		echo 'login anonymous'; \
		echo 'app_update '"${STEAMAPPID}"''; \
		echo 'quit'; \
	   } > "${HOMEDIR}/${STEAMAPP}_update.txt" \
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" "${HOMEDIR}/${STEAMAPP}_update.txt" \	
	&& rm -rf /var/lib/apt/lists/* 
	
# Link server directories
RUN mkdir /server-data \
	&& ln -s /home/steam/Zomboid /server-data \
	&& mkdir /server-files \
	&& ln -s /home/steam/projectzomboid-dedicated /server-files


ENV SERVER_PUBLIC_NAME="Project Zomboid Server on Docker" \
    SERVER_PUBLIC_DESC="" \
	SERVER_PASSWORD="" \
    RCON_PORT=27015 \
    RCON_PASSWORD="projectzomboid-rcon-password" \
	XMX="1G" \
	XMS="4G" \
	ADMIN_PASSWORD="projectzomboidserver"

USER ${USER}

VOLUME ${STEAMAPPDIR}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

# Expose ports
EXPOSE 8766/udp \
	8767/udp \
	16261/udp
	
VOLUME ["/server-data", "/server-files"]
