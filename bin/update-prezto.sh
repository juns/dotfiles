#!/bin/bash

pushd ~/.zprezto
git pull && git submodule update --init --recursive
popd 
