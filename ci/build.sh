#!/bin/bash

set -e -u -x

yum install kernel-{devel,headers}-${KERNEL_VERSION}.el7.x86_64 -y
yum install git gcc make rpm-build -y
cd kernel/linux/rpm/
make
rpmbuild  --rebuild ena-${VERSION}-${RELEASE}.el7.centos.src.rpm
ls -hal /root/rpmbuild/RPMS/x86_64
echo "${gdcustom_key}" > gdcustom-ssh.key
chmod 400 gdcustom-ssh.key
scp -i gdcustom-ssh.key -o "StrictHostKeyChecking no" /root/rpmbuild/RPMS/x86_64/*.rpm ${YUM_USER}@${YUM_SERVER}:/repos/gdcustom-test/7/x86_64/Packages/
ssh -i gdcustom-ssh.key -o "StrictHostKeyChecking no" ${YUM_USER}@${YUM_SERVER} 'createrepo --update /repos/gdcustom-test/7/x86_64'