#!/usr/bin/env bash

repo_file=/etc/yum.repos.d/CentOS-Base.repo
cp $(repo_file) ~/CentOS-Base.repo.backup
sudo sed -i s/#baseurl/baseurl $(repo_file)
sudo sed -i s/mirrorlist.centos.org/vault.centos.org/ $(repo_file)
sudo sed -i s/mirror.centos.org/vault.centos.org/ $(repo_file)
sudo yum clean all
sudo yum install epel-release
sudo yum clean all
