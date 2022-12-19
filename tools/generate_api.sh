#!/bin/sh
set -e

PWD=`pwd`
TEMPLATE='template.yml'
cd `dirname $0`/..

if [ -z "$1" ]; then
    echo "Please enter api name."
else
    # Convert camelCase to score case
    FOLDER_NAME=$(echo $1 | perl -pe 's/([a-z0-9])([A-Z])/$1-\L$2/g')

    # Set folder name
    TARGET_FOLDER_NAME="api-$FOLDER_NAME"

    # Get http method
    HTTP_METHOD=''
    if [ `echo $1 | grep -c "get" ` -gt 0 ]; then
        HTTP_METHOD='get'
    else
        HTTP_METHOD='post'
    fi

    # Check generate folder api
    if [ ! -d "src/$TARGET_FOLDER_NAME" ]; then
        mkdir src/$TARGET_FOLDER_NAME
    fi

    # Generate file index.handler
    if [ "$HTTP_METHOD" = "get" ]; then
        cp -a tools/api-templates/api.get.template src/$TARGET_FOLDER_NAME/index.js
    else
        cp -a tools/api-templates/api.post.template src/$TARGET_FOLDER_NAME/index.js
    fi

    # Create resource for new api
    API_NAME_YML=$(echo $1 | awk '{$1=toupper(substr($1,0,1))substr($1,2)}1')
    API_YML="  $API_NAME_YML:\n"
    API_YML="$API_YML    Type: AWS::Serverless::Function\n"
    API_YML="$API_YML    Properties:\n"
    API_YML="$API_YML      CodeUri: src/$TARGET_FOLDER_NAME\n"
    API_YML+='      FunctionName: !Sub "smartphone-linked-${Stage}-'
    API_YML+=$TARGET_FOLDER_NAME;
    API_YML+='"\n'
    API_YML="$API_YML      Role:\n"
    API_YML="$API_YML        Fn::GetAtt:\n"
    API_YML="$API_YML          - LambdaExecutionRole\n"
    API_YML="$API_YML          - Arn\n"
    API_YML="$API_YML      Events:\n"
    API_YML="$API_YML        $API_NAME_YML:\n"
    API_YML="$API_YML          Type: Api\n"
    API_YML="$API_YML          Properties:\n"
    API_YML="$API_YML            Path: /api/$1\n"
    API_YML="$API_YML            Method: $HTTP_METHOD\n"

    # Read file template to specify inserted line
    # Append new api
    COUNT_LINE=1
    while read line; do
        if [ `echo $line | grep -c "Append New Api" ` -gt 0 ]; then
            break
        fi

        COUNT_LINE=$((COUNT_LINE+1))
    done < $TEMPLATE

    TARGET_OUTPUT_FILE='template.yml.tmp'
    awk -v n=$COUNT_LINE -v s="$API_YML" 'NR == n {print s} {print}' $TEMPLATE > $TARGET_OUTPUT_FILE
    cp -a $TARGET_OUTPUT_FILE $TEMPLATE
    rm -rf $TARGET_OUTPUT_FILE
fi

cd $PWD
