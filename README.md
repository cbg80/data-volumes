# data-volumes
Source code for the building and execution of the images of the cbg80 apps and the orchestration of the containers on top of which run those apps

# how to install
<i>git clone https://github.com/cbg80/data-volumes.git</i>

# how to use
Firstly, [docker](https://www.docker.com) must be also installed locally.<br>
Afterwards, a reminder of some <i>docker</i> commands as far as this package is concerned:<br>
To <b>build</b> the <b>image</b> of the cbg80 ddbb app run<br>
<i>docker build --no-cache --tag cbg80/mariadb-utf8mb4:latest ~/git/data-volumes/servers/ddbb/projects</i>.<br>
To <b>list</b> all the built <b>images</b> run<br>
<i>docker images</i>.<br>
To <b>remove</b> any <b>image</b> run<br>
<i>docker rmi {IMAGE ID}</i>.<br>
To <b>run</b> the previous <b>image</b> run<br>
<i>docker run --interactive --tty --rm --name dbserver --volume ~/git/data-volumes/servers/ddbb/files:/var/lib/mysql --publish 0.0.0.0:3306:3306 cbg80/mariadb-utf8mb4:latest</i>.<br>
To <b>list</b> all the running <b>containers</b> run<br>
<i>docker ps</i>.<br>
To <b>stop</b> any <b>container</b> run<br>
<i>docker stop {CONTAINER ID}</i>.<br>
To <b>build</b>, <b>(re)create</b>, <b>start</b>, <b>attach</b> to <b>containers</b> for the cbg-dbserver and cbg-webserver services and <b>start</b> those <b>services</b> run<br>
<i>docker-compose -f ~/git/data-volumes/servers/web/projects/imageThread/docker-compose.yml up -d</i>.<br>
To contribute with this very same package, bear in mind:<br>
<ol>
<li>there is only one ddbb app shared by all the projects. Locate its building [file](./servers/ddbb/projects/Dockerfile) and its config [file](./servers/ddbb/projects/config/mariadb.cnf).</li>
<li>That app is exposed by one service declared at the very first line of both the [web](./servers/web/projects/imageThread/docker-compose.yml) service declaration and the [api](./servers/web/projects/imageThreadAPI/docker-compose.yml) one.</li>
<li>In case you required different ddbb engines or configuration for the current or for brand new projects, feel free to add folders and files to match your needs. If that is the case, i would go for a directory structure and its contents similar to that under <i>./servers/web/projects</i>. For instance,
<ul>
<li>
a PostgreSQL ddbb app for a project named <u>chore-blog</u> may have its Dockerfile under <i>./servers/ddbb/projects/postgresql</i> and its config file under <i>./servers/ddbb/projects/postgresql/choreBlog/config</i>.
</li>
<li>
The current MariaDB ddbb app for a project dubbed <u>chorus-forum</u> that needs different configuration from any of the others, may have its Dockerfile under <i>./servers/ddbb/projects/chorusForum</i> and its config file at <i>./servers/ddbb/projects/chorusForum/config</i>.
</li>
</ul>
</li>
<li>Regarding the php apps developed without a commercial framework, they all share one web app. Locate its building [file](./servers/web/projects/Dockerfile).</li>
<li>Each of those apps has its own web app configuration. Those configs are complementary, though. Locate the config for the [web](./servers/web/projects/imageThread/config/image-thread.cbg.conf) and [api](./servers/web/projects/imageThreadAPI/config/image-thread-api.cbg.conf) apps.</li>
<li>Each of those apps is exposed by its own service declared separately. Those declarations are complementary, though. Locate the declaration of the [web](./servers/web/projects/imageThread/docker-compose.yml) and [api](./servers/web/projects/imageThreadAPI/docker-compose.yml) services at line 7 in both cases.</li>
<li>Regarding the php apps developed falling back on the Symfony framework, they all share one web app. Locate its building [file](./servers/web/projects/symfony/Dockerfile) and the [script](./servers/web/projects/symfony/docker-entrypoint.sh) that is executed when running the previously built image of that app.</li>
<li>Each of those apps has its own web app configuration. Locate the config for the [web](./servers/web/projects/symfony/SymfonyImageThread/config/image-thread.cbg.conf) app.</li>
<li>Each of those apps is exposed by its own service declared separately. Locate the declaration of the [web](./servers/web/projects/symfony/SymfonyImageThread/docker-compose.yml) service at line 8.</li>
<li>In case you required different php commercial framework or even different web server engine for the current or for brand new projects, feel free to add folders and files to match your needs. If that is the case, i would go for a directory structure and its contents similar to that under <i>./servers/web/projects</i>. For instance,
<ul>
<li>
a GlassFish web app for a project named <u>chore-blog</u> may have its Dockerfile under <i>./servers/web/projects/glassfish</i> and its config file under <i>./servers/web/projects/glassfish/choreBlog/config</i>.
</li>
<li>
A brand new project dubbed <u>chorus-forum</u> that is required to be developed falling back on Laravel php framework, may have its Dockerfile under <i>./servers/web/projects/laravel/chorusForum</i> and its config file at <i>./servers/web/projects/laravel/chorusForum/config</i>.
</li>
</ul>
</li>
</ol>