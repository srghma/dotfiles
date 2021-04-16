# npm config set prefix "/home/node/.npm-global"
# export PATH="/home/node/.npm-global/bin:${PATH}"
# npm i -g npm-check-updates

docker-node () {
  docker run \
    -it \
    --rm \
    --name "$(basename $PWD)-node" \
    -v `pwd`:`pwd` \
    -v /home/srghma/Downloads:/home/srghma/Downloads \
    -w `pwd` \
    node:15.12.0-stretch \
    "$@"
}

docker-ruby () {
  docker run \
    -it \
    --rm \
    --name "$(basename $PWD)-ruby" \
    -v `pwd`:/usr/src/app \
    -w /usr/src/app \
    starefossen/ruby-node:latest \
    "$@"
}

docker-python () {
  docker run \
    -it \
    --rm \
    --name "$(basename $PWD)-python3" \
    -v `pwd`:/usr/src/app \
    -w /usr/src/app \
    python:3 \
    "$@"
}
