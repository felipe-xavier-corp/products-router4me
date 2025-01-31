#!/bin/bash
helpFunction()
{
   echo ""
   echo "Usage: $0 -i ID"
   echo -e "\t-i Id of core to deploy"
   exit 1 
}


while getopts i: flag
do
    case "${flag}" in
        i) id=${OPTARG};;
        ?) helpFunction ;; 
    esac
done

echo $id

if [ -z "$id" ]
    then
        echo "The core Id is empty";
        helpFunction
fi 

cd ..

docker compose -p "router4me-core-$id" down	

exit 0
