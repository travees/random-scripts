#!/bin/sh
#
# Simple script to check when the Mac Mini refurb page changes
#

MD5_STORE="~/.check_apple_md5"

touch $MD5_STORE

LASTMD5=`cat $MD5_STORE`

LINTOUT=`curl -s http://store.apple.com/us/browse/home/specialdeals/mac/mac_mini | xmllint --html --format --xpath '//table[@class="first"]' - 2>/dev/null`

LINTRET=$?
LINTMD5=`md5sum <<<"$LINTOUT"`
echo "$LINTMD5" > $MD5_STORE

if [ $LINTRET -eq 0 ] && [ "x${LASTMD5}" != "x${LINTMD5}" ]
then
	#echo "mac mini refurb" | mail user@domain
	echo "New!"
	
fi
