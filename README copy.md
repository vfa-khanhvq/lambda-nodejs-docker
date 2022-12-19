## Requirement
* nodejs12.x
* npm
* aws
* aws-sam-cli

## Getting started

### Install aws
```
$ curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
$ sudo installer -pkg AWSCLIV2.pkg -target /
```

### Install aws-sam-cli
```
$ pip install aws-sam-cli
```

### Setup Lambda Local
```
$ make start
```

### Migrate table dynamodb
```
$ make migrate
```

### Run local api
```
$ http://localhost:3000/api/v1/login
```

### Run unit test
```
$ yarn test
$ yarn test:watch
```

### Generate new api folder and automatically configuration of template.yml
```
$ make generate_api apiName=saveAccountInfo
※Http Method Get: Please specify get. eg getAccountInfo
```

### Folder structures
```
Root Folder
|_common-layers: Logic Common
|_src: Folder source code api
  |_api-xxx: Folder api
    |_index.js: Code logic api in this file
  |_...
|_database: Folder includes table json files to use migrate table in local
|_tests: Folder source code unit test
  |_test_files: Code unit test in this folder(Format file: test_api_xxx)
```

### Deploy
```
Need to config CI/CD the following steps:
1. Create AWS CodePipeline on AWS Console
2. Configuration new api on template.yml(if needed)
　※Add configuration before line that has the comment 「Append New Api」.
3. Push code
```
