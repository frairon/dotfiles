#!/bin/bash

function gitpullsubs(){
    git submodule foreach git pull origin master
}
