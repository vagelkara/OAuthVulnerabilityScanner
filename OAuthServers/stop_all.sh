#!/bin/bash

echo " stopping KEYCLOACK..."
docker stop keycloak
docker rm keycloak
echo " KEYCLOACK stopped"

echo " stopping casdoor..."
docker stop casdoor
docker rm casdoor
echo " casdoor stopped"

echo " stopping glewlwyd..."
docker stop glewlwyd
docker rm glewlwyd
echo " glewlwyd stopped"

echo " stopping omejdn..."
docker stop omejdn
docker rm omejdn
echo " omejdn stopped"

echo " stopping a12n..."
docker stop a12n
docker rm a12n
echo " a12n stopped"

rm index.html
