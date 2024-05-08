## Create the Virtual Environment Outside of the Shared Folder

```shell
mkdir ~/venv
python3 -m venv ~/venv/custodian
```

## Activate Your Virtual Environment
```shell
source ~/venv/custodian/bin/activate
```

## Install Cloud Custodian
```shell
pip install c7n
```

## Verify Installation
```shell
custodian version
```




