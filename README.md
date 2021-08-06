# GitHub Action to Upload Assets to Azure Blob Storage

This action is designed to use the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) to insert a row of data into a table in your Azure Table Storage account. Mostly designed to be able to upload build meta information, though other use cases may be applicable.

## Usage

### Example

Place in a `.yml` file such as this one in your `.github/workflows` folder. [Refer to the documentation on workflow YAML syntax here.](https://help.github.com/en/articles/workflow-syntax-for-github-actions)

```yaml
name: Upload To Azure Table Storage
on:
  push:
    branches:
      - main
jobs:
  upload:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: LadyCailin/azure-table-storage-upload@v1.0.0
        with:
          table_name: "MyTable"
          partition_key: "Partition Key"
          row_key: "Row Key"
          data: "column1=whatever column2=\"whatever with spaces\""
          if_exists: 'replace'
          extra_args: ''
          connection_string: ${{ secrets.AzureStorageConnectionString }}
```

### Required Variables

| Key                 | Value                                                                      |
|---------------------|----------------------------------------------------------------------------|
| `partition_key`     | The partition key (part of the primary key, see [here](https://docs.microsoft.com/en-us/rest/api/storageservices/designing-a-scalable-partitioning-strategy-for-azure-table-storage) for a discussion on how to choose a good partition key) |
| `row_key`           | The row key (part of the primary key)                                      |
| `data`              | The data to upload. `column=value` format.
| `connection_string` | Your Azure Blob Storage connection string                                  |

### Optional Variables

| Key          | Value                                                                                                                                   |
|--------------|-----------------------------------------------------------------------------------------------------------------------------------------|
| `extra_args` | Extra arguments that can be passed to `az storage entity insert`.                                                                       |
| `sas_token`  | The shared access signature token for the storage account. Either connection\_string or sas\_token must be supplied                     |
| `if_exists`  | The strategy that is used if the primary key already exists, and can be one of `fail`, `merge`, or `replace`. Defaults to fail.         |

## License

This project is distributed under the [Apache 2 license](LICENSE), and is derived from [azure-blob-storage-upload](https://github.com/bacongobbler/azure-blob-storage-upload)