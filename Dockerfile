###########################################################
# Dockerfile that builds a Project Zomboid Gameserver
###########################################################
FROM cm2network/steamcmd:root

ENV STEAMAPPID 380870
ENV STEAMAPP projectzomboid
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
#ENV DLURL https://raw.githubusercontent.com/matm616/ProjectZomboidServer

COPY entry.sh ${HOMEDIR}/entry.sh

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
	&& { \
		echo '@ShutdownOnFailedCommand 1'; \
		echo '@NoPromptForPassword 1'; \
		echo 'force_install_dir '"${STEAMAPPDIR}"' validate'; \
		echo 'login anonymous'; \
		echo 'app_update '"${STEAMAPPID}"''; \
		echo 'quit'; \
	   } > "${HOMEDIR}/${STEAMAPP}_update.txt" \
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& mkdir -p ${HOMEDIR}/Zomboid \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" "${HOMEDIR}/${STEAMAPP}_update.txt" "${HOMEDIR}/${STEAMAPP}-dedicated" "${HOMEDIR}/Zomboid" \	
	&& rm -rf /var/lib/apt/lists/* 
	
# Link server directories
#RUN mkdir -p /home/steam/Zomboid; \
#	mkdir -p /server-data \
#	&& ln -s /home/steam/Zomboid /server-data \
#	&& mkdir -p /server-files \
#	&& ln -s /home/steam/projectzomboid-dedicated /server-files

#RUN [ -d /home/${USER}/Zomboid ] || mkdir -p /home/${USER}/Zomboid && \
#    chown ${USER}:${USER} /home/${USER}/Zomboid && \
#    ln -s /home/${USER}/Zomboid /server-data && \
#    [ -d /home/${USER}/projectzomboid-dedicated ] || mkdir -p /home/${USER}/projectzomboid-dedicated && \
#    chown ${USER}:${USER} /home/${USER}/projectzomboid-dedicated && \
#    ln -s /home/${USER}/projectzomboid-dedicated /server-files


ENV SERVER_PUBLIC_NAME="Project Zomboid Server on Docker" \
    SERVER_PUBLIC_DESC="" \
	SERVER_PASSWORD="" \
    RCON_PORT=27015 \
    RCON_PASSWORD="projectzomboid-rcon-password" \
	XMX="2G" \
	XMS="4G" \
	ADMIN_PASSWORD="projectzomboidserver"

#VOLUME ${STEAMAPPDIR}

WORKDIR ${HOMEDIR}

# Expose ports
EXPOSE 8766/udp \
	8767/udp \
	16261/udp
	
VOLUME ["/home/steam/projectzomboid-dedicated", "/home/steam/Zomboid"]

USER ${USER}

CMD ["bash", "entry.sh"]

#USER root

#CMD ["sleep", "infinity"]