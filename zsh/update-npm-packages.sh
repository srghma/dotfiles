update-npm-packages () {
  docker run -it --rm -v $(pwd)/package.json:/app/package.json creack/ncu --upgradeAll --upgrade --packageFile /app/package.json
}

update-bower-packages () {
  docker run -it --rm -v $(pwd)/bower.json:/app/bower.json creack/ncu --packageManager bower --upgradeAll --upgrade --packageFile /app/bower.json
}
