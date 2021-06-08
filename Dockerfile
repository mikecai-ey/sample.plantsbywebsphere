# Gradle build stage
FROM gradle:7.0.2-jdk8-openj9 as build-stage

COPY . /project
WORKDIR /project

RUN gradle build
RUN gradle copyServerLibs


# Docker Image Build Stage
FROM ibmcom/websphere-liberty:21.0.0.5-kernel-java8-openj9-ubi

COPY --chown=1001:0  --from=build-stage /project/build/wlp/usr/servers/PlantsByWebSphereServer/lib/derby*.jar /config/lib/
COPY --chown=1001:0  --from=build-stage /project/build/libs/PlantsByWebSphere.war /config/apps/
COPY --chown=1001:0  --from=build-stage /project/src/main/liberty/config/server.xml /config/

RUN configure.sh
