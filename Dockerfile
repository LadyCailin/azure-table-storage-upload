FROM mcr.microsoft.com/azure-cli

LABEL "com.github.actions.name"="azure-table-storage-upload"
LABEL "com.github.actions.description"="Uploads values to Azure Table Storage"
LABEL "com.github.actions.icon"="box"
LABEL "com.github.actions.color"="green"
LABEL "repository"="https://github.com/LadyCailin/azure-table-storage-upload"
LABEL "homepage"="https://github.com/LadyCailin/azure-table-storage-upload"
LABEL "maintainer"="Cailin Smith <savannahcailin@gmail.com>"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]