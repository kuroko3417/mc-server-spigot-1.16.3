#!/bin/bash
USERNAME='root'
 
# screen名
SCNAME='minecraft'
 
# minecraft_serverディレクトリ
MC_PATH='/opt/minecraft'
 
# 実行するminecraft_server.jar
SERVICE='spigot-1.16.3.jar'
 
# メモリ設定
XMX='1024M'
XMS='1024M'
  
cd $MC_PATH
 
 
ME=`whoami`
 
if [ $ME != $USERNAME ]; then
  echo "Please run the $USERNAME user."
  exit
fi
 
start() {
  if pgrep -u $USERNAME -f $SERVICE > /dev/null; then
    echo "$SERVICE is already running!"
    exit
  fi
  echo "Starting $SERVICE..."
  screen -AmdS $SCNAME java -Xmx$XMX -Xms$XMS -jar $SERVICE nogui
}
 
stop() {
  if pgrep -u $USERNAME -f $SERVICE > /dev/null; then
    echo "Stopping $SERVICE"
    screen -p 0 -S $SCNAME -X eval 'stuff "say SERVER SHUTTING DOWN IN 10 SECONDS. Saving map..."\015'
    screen -p 0 -S $SCNAME -X eval 'stuff "save-all"\015'
    sleep 10
    screen -p 0 -S $SCNAME -X eval 'stuff "stop"\015'
    sleep 10
    echo "Stopped minecraftserver"
    exit
  else
    echo "$SERVICE is not running!"
    exit
  fi
  screen -p 0 -S $SCNAME -X eval 'stuff "say SERVER SHUTTING DOWN IN 10 SECONDS. "\015'
  sleep 10
  screen -p 0 -S $SCNAME -X eval 'stuff "exit"\015'
}

status() {
  if pgrep -u $USERNAME -f $SERVICE > /dev/null; then
    echo "$SERVICE is already running!"
    exit
  else
    echo "$SERVICE is not running!"
    exit
  fi
}
 
case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  status)
    status
    ;;
  *)
    echo  $"Usage: $0 {start|stop|status}"
esac