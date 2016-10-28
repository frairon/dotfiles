#!/bin/bash

function setgopath(){
  export GOPATH=`pwd`
  export PATH=$PATH:`pwd`/bin
}

function setgoglobal(){
  export GOPATH=HOME/golang-extras
  export PATH=$PATH:`pwd`/bin
}

function atomhere(){
	setgopath
	atom .
}

function gitpullsubs(){
    git submodule foreach git pull origin master
}

function fixmon(){
	xrandr --output eDP1 --auto
	xrandr --output DP3 --auto --left-of eDP1
	xrandr --output DP2 --auto --left-of DP3
}
