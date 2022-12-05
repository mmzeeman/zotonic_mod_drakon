#!/usr/bin/env bash

function install {
    version=$1
    base=https://raw.githubusercontent.com/stepan-mitkin/drakonwidget

    if [ -d priv/lib-src/drakonwidget/$1 ]; then
        echo " - drakonwidget ${version} already installed"
    else
        echo " - Downloading drakonwidget ${version} from github"

        mkdir -p priv/lib-src/drakonwidget/${version};
        cd priv/lib-src/drakonwidget/${version};

        curl -#O ${base}/${version}/libs/drakonwidget.js

        cd ../../../..
    fi

    mkdir -p priv/lib/js;

    cp priv/lib-src/drakonwidget/${version}/drakonwidget.js priv/lib/js/drakonwidget.js
}

install "master" 
