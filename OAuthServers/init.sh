#!/bin/bash
echo " Choose one of the following servers for OAuth Integration"
echo " 0. all"
echo " 1. KEYCLOACK"
echo " 2. casdoor"
echo " 3. glewlwyd"
echo " 4. omejdn"
echo " 5. a12n-server"


read selection

if [[ $selection -eq 1 ]]
then
  echo "You selected KEYCLOACK...."
  echo "Initializing process..."
  echo "Use admin:admin to login on 8080"
    docker run --name=keycloak -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak:18.0.0 start-dev
elif [[ $selection -eq 2 ]]
then 
  echo "You selected casdoor...."
  echo "Initializing process..."
  echo "Use admin:123 to login on 8000"
  docker run --name=casdoor -p 8000:8000 -p 7001:7001 casbin/casdoor-all-in-one
elif [[ $selection -eq 3 ]]
then 
  echo "You selected glewlwyd...."
  echo "Initializing process..."
  echo "Use admin:password to login on 4593"
  docker run --name=glewlwyd --rm -it -p 4593:4593 babelouest/glewlwyd:latest
elif [[ $selection -eq 4 ]]
then 
  echo "You selected omejdn...."
  echo "Initializing process..."
  echo "To login use port 4567"
  cd ./omejdn-server
  docker rm omejdn
  # docker build . -t my-omejdn-server
  docker run -d  --name=omejdn -p 4567:4567 \
              -v $PWD/config:/opt/config \
              -v $PWD/keys:/opt/keys my-omejdn-server
elif [[ $selection -eq 5 ]]
then 
  echo "You selected a12n-server...."
  echo "Initializing process..."
  echo "Use admin:password to login on 8531"
  docker rm a12n
  cd ./a12n-server
  docker run --name=a12n -p 8531:8531 -d a12n-server 
elif [[ $selection -eq 0 ]]
then 
  echo "Starting KEYCLOACK...."
  docker run -d --name=keycloak -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak:18.0.0 start-dev
  echo "Starting casdoor...."
  docker run -d --name=casdoor -p 8000:8000 -p 7001:7001 casbin/casdoor-all-in-one
  echo "Starting glewlwyd...."
  docker run -d --name=glewlwyd --rm -it -p 4593:4593 babelouest/glewlwyd:latest
  cd ./omejdn-server
  docker rm omejdn
  echo "Starting omejdn...."
  docker run -d  --name=omejdn -p 4567:4567 \
                --build-arg OMEJDN_ADMIN=admin:admin \
              -v $PWD/config:/opt/config \
              -v $PWD/keys:/opt/keys my-omejdn-server
  docker rm a12n
  cd ../a12n-server
  echo "Starting a12n...."
  docker run --name=a12n -p 8531:8531 -d a12n-server 
  cd ../
  touch index.html
  echo '<a href="http://localhost:8080"> KEYCLOACK </a><br>' >> index.html
  echo '<a href="http://localhost:8000"> casdoor </a><br>' >> index.html
  echo '<a href="http://localhost:4593"> glewlwyd </a><br>' >> index.html
  echo '<a href="http://localhost:4567"> omejdn </a><br>' >> index.html
  echo '<a href="http://localhost:8531"> a12n </a>' >> index.html
  firefox ./index.html &
fi
