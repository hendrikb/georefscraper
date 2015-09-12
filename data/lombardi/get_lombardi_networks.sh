#!/bin/bash
urls=$(curl http://www.lombardinetworks.net/networks/the-networks/ | grep -i -o 'http://www.lombardi[^>]\+\.graphml' | sort | uniq)

wget --no-directories -N $urls

# these files contain some duplicate line errors, delete them:
sed -e'776,779d' -i HarkenBush5th.graphml
sed -e'948,951d' -i NuganHandBank.graphml
