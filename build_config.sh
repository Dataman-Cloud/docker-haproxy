#!/bin/sh
set -eu
BASE_DIR=$(cd `dirname $0` && pwd)
cd $BASE_DIR

BACKEND_LIST=$(echo $BACKEND_LIST |sed "s/,/ /g")
BACKEND_MAXCONN=${BACKEND_MAXCONN:-20}
SERVICE_NAME=${SERVICE_NAME:-testserver}
SERVICE_PORT=${SERVICE_PORT:-80}
SERVERS=""

num=1
for SERVER_IP in $BACKEND_LIST;do
    SERVERS="$SERVERS server $SERVICE_NAME-$SERVER_IP:$SERVICE_PORT $SERVER_IP:$SERVICE_PORT check port $SERVICE_PORT maxconn $BACKEND_MAXCONN\n"
    num=`expr $num + 1`
done

replace_var(){
    files=$@
    echo $files | xargs sed -i 's/--SERVICE_NAME--/'"$SERVICE_NAME"'/g'
    echo $files | xargs sed -i 's/--SERVICE_PORT--/'"$SERVICE_PORT"'/g'
    echo $files | xargs sed -i 's/--SERVERS--/'"$SERVERS"'/g'
}

pre_conf(){
    rm -f $1
    cp $1.temp $1
    files="$1"
    replace_var $files
}


prehaproxy_conf(){
    rm -rf
    cp -rf conf.temp conf_tmp

    files=`grep -rl '' conf_tmp/*`
    replace_var $files

    rm -rf conf
    mv conf_tmp conf
}

pre_conf haproxy.cfg
