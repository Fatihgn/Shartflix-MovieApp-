#!/bin/bash

# sh script/build.sh force
if [ "$1" = "force" ]
then
    dart run build_runner build  --delete-conflicting-outputs
else
    dart run build_runner build
fi