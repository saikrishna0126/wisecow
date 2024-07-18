#!/usr/bin/env bash

SRVPORT=4499
RSPFILE=response

# Debugging: Print starting message
echo "Starting Wisecow script..."

# Clean up any existing response file and create a new one
rm -f $RSPFILE
mkfifo $RSPFILE

get_api() {
	read line
	echo $line
}

handleRequest() {
    # Process the request
	get_api
	mod=`fortune`

cat <<EOF > $RSPFILE
HTTP/1.1 200

<pre>`cowsay $mod`</pre>
EOF
}

prerequisites() {
    echo "Checking for prerequisites..."
    command -v cowsay >/dev/null 2>&1 || { echo "cowsay not found."; exit 1; }
    command -v fortune >/dev/null 2>&1 || { echo "fortune not found."; exit 1; }
}

main() {
	prerequisites
	echo "Wisdom served on port=$SRVPORT..."

	while [ 1 ]; do
		cat $RSPFILE | nc -lN $SRVPORT | handleRequest
		sleep 0.01
	done
}

main
