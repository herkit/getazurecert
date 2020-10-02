FROM microsoft/azure-cli
WORKDIR /app
COPY ["entrypoint.sh", "src/getazurecert", "." ]
RUN chmod +x getazurecert
ENTRYPOINT '/app/entrypoint.sh'