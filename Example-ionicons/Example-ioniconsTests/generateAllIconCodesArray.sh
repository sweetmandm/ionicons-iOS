#!/bin/sh

#  generateAllIconsArray.sh
#  Example-ionicons
#
#  Created by Daniel Morgan on 4/18/15.
#  Copyright (c) 2015 TapTemplate. All rights reserved.

SCRIPT_PATH="$(dirname "$0")" || .
CODES_PATH=$SCRIPT_PATH/../../ionicons/ionicons-codes.h
OUTPUT_PATH=$SCRIPT_PATH/allIconCodes.h

rm $OUTPUT_PATH

echo "// This file is auto-generated." > $OUTPUTH_PATH
echo "//This file contains all icon codes for testing purposes." >> $OUTPUT_PATH
echo "// This is the file that has been generated." >> $OUTPUT_PATH
echo "" >> $OUTPUT_PATH
echo "#import <Foundation/Foundation.h>" >> $OUTPUT_PATH
echo '#import "ionicons-codes.h"' >> $OUTPUT_PATH
echo "static NSArray *allIconCodes() {" >> $OUTPUT_PATH

OUTPUT_STRING="    return @["
while read p; do
    OUTPUT_STRING=${OUTPUT_STRING}"$(echo $p | awk -F ' ' '{print $2}'), "
done <$CODES_PATH

echo ${OUTPUT_STRING} >> $OUTPUT_PATH
echo "];}" >> $OUTPUT_PATH
