#! /usr/bin/env sh

cd ~/racine/plugin/manager/el-get

[[ -d el-get ]] || {

	echo "git clone https://github.com/dimitri/el-get.git"

	git clone https://github.com/dimitri/el-get.git

}
