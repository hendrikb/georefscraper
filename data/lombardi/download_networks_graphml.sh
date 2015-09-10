#!/bin/bash
urls=$(curl http://www.lombardinetworks.net/networks/the-networks/ | grep -i -o 'http://www.lombardi[^>]\+\.graphml' | sort | uniq)

wget --no-directories -N $urls
