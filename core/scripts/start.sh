#!/bin/bash
helpFunction()
{
   echo ""
   echo "Usage: $0 -i ID -b"
   echo -e "\t-i Id of core to deploy"
   echo -e "\t-b Build the applicaton"
   exit 1 
}

build=0

while getopts i:build flag
do
    case "${flag}" in
        i) id=${OPTARG};;
        b) build=1;;
        ?) helpFunction ;; 
    esac
done

if [ -z "$id" ] 
    then
        echo "The core ID can't be empty";
        helpFunction
fi 

cd ..

if test -f "./envs/$id.env"; 
    then
        cp "./envs/$id.env"  ".env"
fi

export COREID="$id"

if [ $build -eq 1 ]
    then
        docker compose  -p "router4me-core-$id" up -d --build	
    else
        docker compose -p "router4me-core-$id" up -d 
fi   

if test -f "./envs/$id.env"; 
    then
        rm ".env"
fi

exit 0
