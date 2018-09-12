Reduced image size approach for Oracle Middleware on Docker
=====

## !ATTENTION!

This approach is only implemented for
 - OrcaleJava 8
 - OrcaleFMWInfrastructure 12.2.1.3
 - OracleFormsReports 12.2.13

## !ATTENTION!
Checksumming and file checks are disabled
----------

## Here you go
I placed a "reduced size" build next to the upstream one. To reduce the size the source artefacts are not added by ADD/COPY to the docker image. Instead a temporary Webserver using nginx is startet and the artefacts will be downloaded from within Dockerfile. 

1. Download the upstream files needed (see README.md) but place them in oracleResources
2. Edit vars.sh: RESSRV must point to the address docker containers of your build engine are accessible by
3. Follow the READMEs but use buildDocerImageOpt.sh instead of buildDockerImage.sh 
4. Use/Start/Create as usual. The Images should be exactly the same as before. But a bit smaller. 


All three builds work like this:
1. Start nginx webserver via docker, using oracleResources folder as a webroot
2. Start docker build with the DockerfileOpt and build-arg RESSRV set to the above server
3. Within DockerfileOpt no ADD/COPY is used, cause we only need the large source artefacts for installation. If we delete after COPY/ADD the layer is preserved. So instead within a single RUN command the sources are downloaded, installed to target and removed afterwards
4. The container with nginx is stopped and removed

## Results

Differences:
If I build without Opt-changes my results are these:
REPOSITORY                      TAG                 IMAGE ID            CREATED             SIZE
localhost/oracle/formsreports   12.2.1.3            e3625789c5bf        25 seconds ago      12.5GB
oracle/fmw-infrastructure       12.2.1.3            7f10ba962c8d        2 hours ago         6.04GB
oracle/serverjdk                8                   83421005be35        2 hours ago         615MB
oraclelinux                     latest              4119345b2795        7 days ago          234MB


With the given changes I get these:
REPOSITORY                      TAG                 IMAGE ID            CREATED             SIZE
localhost/oracle/formsreports   12.2.1.3            1757d6f1fe62        3 hours ago         5.57GB
oracle/fmw-infrastructure       12.2.1.3            1698459fa239        3 hours ago         2.79GB
oracle/serverjdk                8                   7f8a6566269e        3 hours ago         615MB
oraclelinux                     latest              4119345b2795        10 days ago         234MB
