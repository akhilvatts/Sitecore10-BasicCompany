# escape=`

ARG BASE_IMAGE

FROM ${BASE_IMAGE}

ARG ARTIFACT_PATH

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

WORKDIR C:\sps

# Copy solution website files
COPY  ${ARTIFACT_PATH} .