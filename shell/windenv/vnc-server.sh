#!/usr/bin/env sh

# password {{{1

echo -n 'New password ? '
read answer

[ $answer = y -o $answer = yes ] && \
	x11vnc -storepasswd ~/.vnc/passwd

# computing scaling ration {{{1

client=${1:-mandala.local}

echo client : $client
echo

server_info=$(xdpyinfo | grep dimension)
server_int=${server_info#*dimensions: }
server_resolution=${server_int% pixels*}
server_width=${server_resolution%x*}

echo server info : $server_info
echo server int : $server_int
echo server resolution : $server_resolution
echo server width : $server_width
echo

client_info=$(command ssh -X $client xdpyinfo | grep dimension)
echo
client_int=${client_info#*dimensions: }
client_resolution=${client_int% pixels*}
client_width=${client_resolution%x*}

echo client info : $client_info
echo client resolution : $client_resolution
echo client width : $client_width
echo

ratio=$(echo "scale=4 ; $client_width/$server_width" | bc)

echo ratio : $ratio
echo

# launching server {{{1

ip -4 a

port=5900

#exec x11vnc -forever -display $DISPLAY -rfbport $port -rfbauth ~/.vnc/passwd

echo "exec x11vnc -scale $ratio -localhost -forever -display $DISPLAY -rfbport $port -rfbauth ~/.vnc/passwd"

exec x11vnc -scale $ratio -localhost -forever -display $DISPLAY -rfbport $port -rfbauth ~/.vnc/passwd

# ss -ltnp | grep 5900
