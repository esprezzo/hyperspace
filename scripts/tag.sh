#!/bin/bash

TAG=v0.1.0
ANNOTATION="les go"
git tag -a $TAG -m "$ANNOTATION"
git push origin $TAG

# Delete local:
# git tag -d $TAG
# Delete remote: 
# git push --delete origin tagname