# To build, cd to this directory, then:
#   docker build --build-arg SSP_LICENSE_FILE="ssp-rstudio-license-2024-09-06.lic" -t rstudio/shinycoreci:ssp-3.6-bionic .
#   docker build --build-arg EXTRA_BASE_TAG=-rc_v1.4.0.1 --build-arg SSP_LICENSE_FILE="ssp-rstudio-license-2024-09-06.lic" -t rstudio/shinycoreci:ssp-3.6-bionic-rc_v1.4.0.1 .

# To run:
#   docker run --rm -p 4949:3838 --name ssp_bionic rstudio/shinycoreci:ssp-3.6-bionic
#   docker run --rm -p 4949:3838 --name ssp_bionic rstudio/shinycoreci:ssp-3.6-bionic-rc_v1.4.0.1


# "ubuntu" = switch(release, "xenial" = "ubuntu-12.04", "ubuntu-14.04")
ARG R_VERSION=3.6
ARG RELEASE=bionic
ARG EXTRA_BASE_TAG=
FROM rstudio/shinycoreci:base-${R_VERSION}-${RELEASE}${EXTRA_BASE_TAG}

ARG R_VERSION=3.6
ARG RELEASE=bionic
ARG EXTRA_BASE_TAG=
ARG AWS_BUILD_MACHINE=ubuntu-14.04

RUN apt-get update && apt-get install -y \
  libssl1.0.0 \
  psmisc

# =====================================================================
# Shiny Server
# =====================================================================

# Download and install shiny server pro
RUN wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-pro-build/${AWS_BUILD_MACHINE}/x86_64/VERSION" -O "version.txt" && \
  VERSION=$(cat version.txt)  && \
  wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-pro-build/${AWS_BUILD_MACHINE}/x86_64/shiny-server-commercial-$VERSION-amd64.deb" -O ssp-latest.deb && \
  gdebi -n ssp-latest.deb && \
  rm -f ssp-latest.deb && \
  rm /srv/shiny-server/index.html

# activate license
ARG SSP_LICENSE_FILE
COPY ${SSP_LICENSE_FILE} ssp.lic
RUN wc -l ssp.lic && \
  /opt/shiny-server/bin/license-manager activate-file ssp.lic > /dev/null 2>&1 && \
  rm ssp.lic

RUN echo "${R_VERSION}-${RELEASE}${EXTRA_BASE_TAG} Shiny Server PRO: `cat version.txt`\n" >> /srv/shiny-server/__version && \
  rm -f version.txt
