#!/bin/bash

echo "Hello, Marco!" > index.html
nohup busybox httpd -f -p 80 &