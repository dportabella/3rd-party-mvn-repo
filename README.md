# 3rd-party-mvn-repo
maven repository for third-party unpublished artifacts

This repository was build by executing the `build.sh` script.
The script depends on third-party files, and so it is not guaranteed to work forever (which is also why this repository exists).
It uses [git-lfs](https://git-lfs.github.com/) for storing large files.


For sbt users, you can add the following snippet to `build.sbt` to use this repo:
```
resolvers += "dportabella-3rd-party-mvn-repo-releases" at "https://github.com/dportabella/3rd-party-mvn-repo/raw/master/releases/"
resolvers += "dportabella-3rd-party-mvn-repo-snapshots" at "https://github.com/dportabella/3rd-party-mvn-repo/raw/master/snapshots/"
```

or this snippet to `pom.xml` for maven users:
```
<repositories>
  <repository>
    <id>dportabella-3rd-party-mvn-repo-releases</id>
    <url>https://github.com/dportabella/3rd-party-mvn-repo/raw/master/releases/</url>
  </repository>
  <repository>
    <id>dportabella-3rd-party-mvn-repo-snapshots</id>
    <url>https://github.com/dportabella/3rd-party-mvn-repo/raw/master/snapshots/</url>
  </repository>
</repositories>
```

This repo is also synchronised to a Dropbox account, so you can use the following snippet if you prefer not to overload github:
```
resolvers += "dportabella-3rd-party-mvn-repo-releases" at "https://dl.dropboxusercontent.com/u/3796323/3rd-party-mvn-repo/releases/"
resolvers += "dportabella-3rd-party-mvn-repo-snapshots" at "https://dl.dropboxusercontent.com/u/3796323/3rd-party-mvn-repo/snapshots/"
```


This repo currently contains:
- com.github.dportabella.3rd-party-mvn-repo:jdeserialize:1.0.0
- com.sleepycat:je:4.1.6
- de.l3s:web2warc_2.11:1.0
- org.warcbase:warcbase:0.1.0-SNAPSHOT
- org.warcbase:warcbase:0.1.0-20161019.161926-1
- org.warcbase:warcbase-hbase:0.1.0-SNAPSHOT
- org.warcbase:warcbase-hbase:0.1.0-20161019.162100-1



```
$ find . -iname "*.jar"
./releases/com/github/dportabella/3rd-party-mvn-repo/jdeserialize/1.0.0/jdeserialize-1.0.0.jar
./releases/com/sleepycat/je/4.1.6/je-4.1.6.jar
./releases/de/l3s/web2warc_2.11/1.0/web2warc_2.11-1.0-javadoc.jar
./releases/de/l3s/web2warc_2.11/1.0/web2warc_2.11-1.0-sources.jar
./releases/de/l3s/web2warc_2.11/1.0/web2warc_2.11-1.0.jar
./snapshots/org/warcbase/warcbase-core/0.1.0-SNAPSHOT/warcbase-core-0.1.0-20161019.161953-1-fatjar.jar
./snapshots/org/warcbase/warcbase-core/0.1.0-SNAPSHOT/warcbase-core-0.1.0-20161019.161953-1.jar
./snapshots/org/warcbase/warcbase-hbase/0.1.0-SNAPSHOT/warcbase-hbase-0.1.0-20161019.162100-1-fatjar.jar
./snapshots/org/warcbase/warcbase-hbase/0.1.0-SNAPSHOT/warcbase-hbase-0.1.0-20161019.162100-1.jar


$ find . -iname "*.pom"
./releases/com/github/dportabella/3rd-party-mvn-repo/jdeserialize/1.0.0/jdeserialize-1.0.0.pom
./releases/com/sleepycat/je/4.1.6/je-4.1.6.pom
./releases/de/l3s/web2warc_2.11/1.0/web2warc_2.11-1.0.pom
./snapshots/org/warcbase/warcbase/0.1.0-SNAPSHOT/warcbase-0.1.0-20161019.161926-1.pom
./snapshots/org/warcbase/warcbase-core/0.1.0-SNAPSHOT/warcbase-core-0.1.0-20161019.161953-1.pom
./snapshots/org/warcbase/warcbase-hbase/0.1.0-SNAPSHOT/warcbase-hbase-0.1.0-20161019.162100-1.pom
```
