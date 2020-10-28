# data-volumes
Source code for the building and execution of the images of the cbg80 apps and the orchestration of the containers on top of which run those apps

# how to install
<i>git clone https://github.com/cbg80/data-volumes.git</i>

# how to use
For <b>building</b> the <b>image</b> of the cbg80 ddbb app run<br>
<i>docker build --no-cache --tag cbg80/mariadb-utf8mb4:latest /home/user/git/data-volumes/servers/ddbb/config</i>.<br>
For <b>listing</b> all the built <b>images</b> run<br>
<i>docker images</i>.<br>
For <b>removing</b> any <b>image</b> run<br>
<i>docker rmi {IMAGE ID}</i>.<br>
For <b>running</b> the previous <b>image</b> run<br>
<i>docker run --interactive --tty --rm --name dbserver --volume /home/cbg80/git/data-volumes/servers/ddbb/files:/var/lib/mysql --publish 0.0.0.0:3306:3306 cbg80/mariadb-utf8mb4:latest</i>.<br>
For <b>listing</b> all the running <b>containers</b> run<br>
<i>docker ps</i>.<br>
For <b>stopping</b> any <b>container</b> run<br>
<i>docker stop {CONTAINER ID}</i>.<br>