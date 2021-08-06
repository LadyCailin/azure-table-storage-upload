#!/bin/sh

set -e

if [ -z "$INPUT_TABLE_NAME" ]; then
  echo "Table name is not set. Quitting."
  exit 1
fi

if [ -z "$INPUT_PARTITION_KEY" ]; then
  echo "Partition key is not set. Quitting."
  exit 1
fi

if [ -z "$INPUT_ROW_KEY" ]; then
  echo "Partition key is not set. Quitting."
  exit 1
fi

if [ -z "$INPUT_DATA" ]; then
  echo "Row key is not set. Quitting."
  exit 1
fi

CONNECTION_METHOD=""

if ! [ -z "$INPUT_CONNECTION_STRING" ]; then
  CONNECTION_METHOD="--connection-string $INPUT_CONNECTION_STRING"
elif ! [ -z "$INPUT_SAS_TOKEN" ]; then
  if ! [ -z "$INPUT_ACCOUNT_NAME" ]; then
    CONNECTION_METHOD="--sas-token $INPUT_SAS_TOKEN --account-name $INPUT_ACCOUNT_NAME"
  else
    echo "account_name is required if using a sas_token. account_name is not set. Quitting."
    exit 1
  fi
else
  echo "either connection_string or sas_token are required and neither is set. Quitting."
  exit 1
fi

EXTRA_ARGS=""
if ! [ -z "$INPUT_EXTRA_ARGS" ]; then
  EXTRA_ARGS=${INPUT_EXTRA_ARGS}
fi

IF_EXISTS="fail"
if ! [ -z "$INPUT_IF_EXISTS" ]; then
  IF_EXISTS=${INPUT_IF_EXISTS}
fi

az storage entity insert ${CONNECTION_METHOD} --table-name "${INPUT_TABLE_NAME}" --entity PartitionKey=${INPUT_PARTITION_KEY} RowKey=${INPUT_ROW_KEY} ${INPUT_DATA} --if-exists ${IF_EXISTS} ${EXTRA_ARGS}