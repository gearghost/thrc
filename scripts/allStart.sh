#!/bin/bash

APP_DIR=$(cd `dirname $0`/../; pwd)
echo "$APP_DIR"
cd $APP_DIR

mkdir -p $APP_DIR/logs

ACCOUNT_SERVICE=account-service
USER_SERVICE=user-service
ACCOUNT_INTERFACE=account-interface
GATEWAY=gateway

ACCOUNT_SERVICE_LOG=$APP_DIR/logs/$ACCOUNT_SERVICE.log
USER_SERVICE_LOG=$APP_DIR/logs/$USER_SERVICE.log
ACCOUNT_INTERFACE_LOG=$APP_DIR/logs/$ACCOUNT_INTERFACE.log
GATEWAY_LOG=$APP_DIR/logs/$GATEWAY.log

BUILD_PATH1=$APP_DIR/bin/service/$ACCOUNT_SERVICE
BUILD_PATH2=$APP_DIR/bin/service/$USER_SERVICE
BUILD_PATH3=$APP_DIR/bin/interface/$ACCOUNT_INTERFACE
BUILD_PATH4=$APP_DIR/bin/interface/$GATEWAY

echo "------------------start $ACCOUNT_SERVICE------------------"
echo "nohup $BUILD_PATH1 >>$ACCOUNT_SERVICE_LOG 2>&1 &"
nohup $BUILD_PATH1 >>$ACCOUNT_SERVICE_LOG 2>&1 &

echo "------------------start $USER_SERVICE------------------"
echo "nohup $BUILD_PATH2 >>$USER_SERVICE_LOG 2>&1 &"
nohup $BUILD_PATH2 >>$USER_SERVICE_LOG 2>&1 &

echo "------------------start $ACCOUNT_INTERFACE------------------"
echo "nohup $BUILD_PATH3 >>$ACCOUNT_INTERFACE_LOG 2>&1 &"
nohup $BUILD_PATH3 >>$ACCOUNT_INTERFACE_LOG 2>&1 &

echo "------------------start $GATEWAY------------------"
echo "nohup $BUILD_PATH4 >>$GATEWAY_LOG 2>&1 &"
nohup $BUILD_PATH4 >>$GATEWAY_LOG 2>&1 &
