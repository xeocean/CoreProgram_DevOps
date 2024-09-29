#!/bin/bash

spawn-fcgi -p 8080 fcgi_server
nginx -g "daemon off;"
nginx -s reload
