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

echo "------------------delete $ACCOUNT_SERVICE------------------"
echo "rm $BUILD_PATH1"
rm $BUILD_PATH1

echo "------------------delete $USER_SERVICE------------------"
echo "rm $BUILD_PATH2"
rm $BUILD_PATH2

echo "------------------delete $ACCOUNT_INTERFACE------------------"
echo "rm $BUILD_PATH3"
rm $BUILD_PATH3

echo "------------------delete $GATEWAY------------------"
echo "rm $BUILD_PATH4"
rm $BUILD_PATH4
