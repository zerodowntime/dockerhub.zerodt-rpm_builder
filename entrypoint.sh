#!/bin/bash

if [ ! -f "/home/rpm/rpmbuild/SPECS/$SPEC_FILE_NAME" ]; then
  echo "Error! spec file not exist: rpmbuild/SPECS/${SPEC_FILE_NAME}"
  exit 1
fi

yum -y update;
spectool -g -R -A "/home/rpm/rpmbuild/SPECS/${SPEC_FILE_NAME}"
sudo yum-builddep -y "/home/rpm/rpmbuild/SPECS/${SPEC_FILE_NAME}"
rpmbuild -ba "/home/rpm/rpmbuild/SPECS/${SPEC_FILE_NAME}"
exit $?
