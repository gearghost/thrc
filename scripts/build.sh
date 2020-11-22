#!/bin/bash

APP_DIR=$(cd `dirname $0`/../; pwd)
echo "$APP_DIR"
cd $APP_DIR

ACCOUNT_SERVICE=account-service
USER_SERVICE=user-service
ACCOUNT_INTERFACE=account-interface
GATEWAY=gateway

BUILD_PATH1=$APP_DIR/bin/service/$ACCOUNT_SERVICE
BUILD_PATH2=$APP_DIR/bin/service/$USER_SERVICE
BUILD_PATH3=$APP_DIR/bin/interface/$ACCOUNT_INTERFACE
BUILD_PATH4=$APP_DIR/bin/interface/$GATEWAY

help(){
    echo ""
    echo "build script"
    echo "Usage: ./build.sh [-h]"
    echo ""
}

while getopts "o:h" arg
do
    case $arg in
        h)
            help;
            exit 0
            ;;
        o)
            OS_TYPE=$OPTARG
            ;;
        ?)
            echo "No argument needed. Ignore them all!"
            ;;
    esac
done

if [[ "$OS_TYPE" == "Darwin" || "$OS_TYPE" == "darwin" || "$OS_TYPE" == "mac" ]];then
    echo "GO Target Arch: " $OS_TYPE
    export CGO_ENABLED=0
    export GOOS=darwin
fi

if [[ "$OS_TYPE" == "Linux" || "$OS_TYPE" == "linux" ]];then
    echo "GO Target Arch: " $OS_TYPE
    export CGO_ENABLED=0
    export GOOS=linux
fi


echo "------------------build $ACCOUNT_SERVICE------------------"
echo "go build -o $BUILD_PATH1"
cd $APP_DIR/service/account/cmd
go build -tags netgo -o $BUILD_PATH1


echo "------------------build $USER_SERVICE------------------"
echo "go build -o $BUILD_PATH2"
cd $APP_DIR/service/user/cmd
go build -tags netgo -o $BUILD_PATH2


echo "------------------build $ACCOUNT_INTERFACE------------------"
echo "go build -o $BUILD_PATH3"
cd $APP_DIR/interface/account/cmd
go build -tags netgo -o $BUILD_PATH3

echo "------------------build $GATEWAY------------------"
echo "go build -o $BUILD_PATH4"
cd $APP_DIR/interface/gateway/cmd
go build -tags netgo -o $BUILD_PATH4
