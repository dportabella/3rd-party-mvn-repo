#! /bin/bash

# info on creating a maven repository on github:
#   https://cemerick.com/2010/08/24/hosting-maven-repos-on-github/
#   http://www.scala-sbt.org/0.13/docs/Publishing.html
# info on big files in git: https://git-lfs.github.com/

# do create a new repository on github: https://github.com/dportabella/3rd-party-mvn-repo
# with name: dportabella/3rd-party-mvn-repo
# with description: maven repository for third-party unpublished artifacts

set -e

# how to properly ignore error if already installed?
! brew install git-lfs

mkdir 3rd-party-mvn-repo
cd 3rd-party-mvn-repo
DIR=$(pwd)

mkdir $DIR/snapshots
mkdir $DIR/releases

# deprecated
# org.warcbase:warcbase:0.1.0-SNAPSHOT
# cd $(mktemp -d -t gitclone)
# git clone http://github.com/lintool/warcbase.git
# cd warcbase
# mvn -DaltDeploymentRepository=snapshot-repo::default::file:$DIR/snapshots deploy -DskipTests

# com.sleepycat:je:4.1.6
cd $(mktemp -d -t gitclone)
wget -r -np "http://builds.archive.org/maven2/com/sleepycat/"
find . -iname index.html -delete
mkdir $DIR/releases/com/
mv builds.archive.org/maven2/com/sleepycat $DIR/releases/com/

## alternative to previous com.sleepycat:je:4.1.6
# cd /tmp/
# wget http://builds.archive.org/maven2/com/sleepycat/je/4.1.6/je-4.1.6.jar
# wget http://builds.archive.org/maven2/com/sleepycat/je/4.1.6/je-4.1.6.pom
# mvn -Dmaven.repo.local=$DIR/releases/ install:install-file -Dfile=je-4.1.6.jar -DpomFile=je-4.1.6.pom

# Web2Warc
cd $(mktemp -d -t gitclone)
git clone https://github.com/helgeho/Web2Warc.git
cd Web2Warc
cat >>build.sbt <<EOF
scalaVersion := "2.11.7"
publishTo := Some(Resolver.file("file",  new File( "$DIR/releases/" )) )
EOF
sbt publish


# hadoop-core:0.20.2-cdh3u4 (dependency of Web2Warc)
cd $(mktemp -d -t hadoop-core)
wget http://www.java2s.com/Code/JarDownload/hadoop-core/hadoop-core-0.20.2-cdh3u4.jar.zip
unzip hadoop-core-0.20.2-cdh3u4.jar.zip
mvn -Dmaven.repo.local=$DIR/releases/ install:install-file \
    -Dfile=hadoop-core-0.20.2-cdh3u4.jar \
    -DgroupId=org.apache.hadoop -DartifactId=hadoop-core -Dversion=0.20.2-cdh3u4 -Dpackaging=jar


# jdeserialize
cd $(mktemp -d -t gitclone)
git clone https://github.com/unsynchronized/jdeserialize.git
cd jdeserialize/jdeserialize/
ant
mvn -Dmaven.repo.local=$DIR/releases/ install:install-file \
    -Dfile=jdeserialize.jar \
    -DgroupId=com.github.dportabella.3rd-party-mvn-repo -DartifactId=jdeserialize -Dversion=1.0.0 -Dpackaging=jar


# woksearchlite
cd $(mktemp -d -t gitclone)
git clone https://github.com/dportabella/woksearchlite.git
cd woksearchlite
cat >>build.sbt <<EOF
publishTo := Some(Resolver.file("file",  new File( "$DIR/snapshots/" )) )
EOF
(sbt +publish) # it fails the first time.
sbt +publish


# jsoup fix_nbsp_publish
cd $(mktemp -d -t gitclone)
git clone https://github.com/dportabella/jsoup.git
cd jsoup
git checkout fix_nbsp_publish
mvn -DaltDeploymentRepository=snapshot-repo::default::file:$DIR/snapshots deploy


cd $DIR
git init
git lfs install
git lfs track "*.jar"  # it creates .gitattributes and lfs/
git add .gitattributes README.md build.sh releases/ snapshots/
git commit -m "initial commit"


# git remote add origin git@github.com:dportabella/3rd-party-mvn-repo.git
# git push origin master:master
## test it
# cd /tmp
# wget "https://github.com/dportabella/3rd-party-mvn-repo/raw/master/releases/com/sleepycat/je/4.1.6/je-4.1.6.jar"
# wget "https://github.com/dportabella/3rd-party-mvn-repo/raw/master/snapshots/org/warcbase/warcbase-core/0.1.0-SNAPSHOT/warcbase-core-0.1.0-20161019.161953-1.jar"
