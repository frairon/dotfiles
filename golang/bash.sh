#!/bin/bash


function setgopath(){
  export GOPATH=`pwd`
  export PATH=$PATH:`pwd`/bin
}

function setgoglobal(){
  export GOPATH=$HOME/golang-extras
  export PATH=$PATH:`pwd`/bin
}
