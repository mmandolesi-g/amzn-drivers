#!/bin/bash

set -e -u -x
ls -hal
yum install kernel-{devel,headers}-3.10.0-514.6.2.el7.x86_64 -y
yum install git gcc make rpm-build -y
cd kernel/linux/rpm/
make
rpmbuild  --rebuild ena-1.1.3-1.el7.centos.src.rpm
ls -hal /root/rpmbuild/RPMS/x86_64
cp /root/rpmbuild/RPMS/x86_64/*.rpm ../../../../rpm-artifacts/
ls -hal ./../../../rpm-artifacts/
# echo "${gdcustom_key}" > gdcustom-ssh.key
# chmod 400 gdcustom-ssh.key
# scp -i gdcustom-ssh.key -o "StrictHostKeyChecking no" /root/rpmbuild/RPMS/x86_64/*.rpm yumrepo@10.84.115.4:/repos/gdcustom-test/7/x86_64/Packages/
# ssh -i gdcustom-ssh.key -o "StrictHostKeyChecking no" yumrepo@10.84.115.4 'createrepo --update /repos/gdcustom-test/7/x86_64'