#!/bin/bash

APP_DIR=$(cd `dirname $0`/../; pwd)
echo "$APP_DIR"
cd $APP_DIR

ACCOUNT_SERVICE=account-service
USER_SERVICE=user-service
ACCOUNT_INTERFACE=account-interface
GATEWAY=gateway

echo "------------------stop $ACCOUNT_SERVICE------------------"
echo "pkill $ACCOUNT_SERVICE"
pkill $ACCOUNT_SERVICE

echo "------------------stop $USER_SERVICE------------------"
echo "pkill $USER_SERVICE"
pkill $USER_SERVICE

echo "------------------stop $ACCOUNT_INTERFACE------------------"
echo "pkill $ACCOUNT_INTERFACE"
pkill $ACCOUNT_INTERFACE

echo "------------------stop $GATEWAY------------------"
echo "pkill $GATEWAY"
pkill $GATEWAY
