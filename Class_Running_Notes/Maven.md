Continuous Integration(CI):

  Src (Repo) -> Build(Compile) -> Static Analysis -> Unit Tests -> Package -> Artifactory Repo -> Deployment (Servers/Containers) -> Post Deployment Test Cases

CD/CD:

  Delivery: CI -> Manual -> Prod -> Monitoring
  Deployment: CI -> Auto -> Prod -> Monitoring

Tools:

Jenkins ->
Src Repo (Git/GitHUB) -> Build(Maven) -> Static Analysis (Sonar Qube) -> Unit Tests (Junit) -> Package (Artifact/Docker Image) -> Artifactory Repo (Nexus / DockerHub) -> Deployment (Servers (Tomcat) / Containers (Docker, Docker Compose, K8s)) -> Post Deployment Test Cases (Selenium / Junit) -> Configuration Mgmt Tools (Terraform / Ansible/ Puppet) -> Monitoring (Nagios)

Java Based Application:
=======================

*.java

  - Core Java (J2SE - Java 2 Standard Edition)
    - Standard Alone Applications
      - Ex: Applets, Threads, Socket
    - Runtime Environment - JRE
    - Package (*.java): .jar

      src code (*.java) -> Build (Compile) -> Unit Tests (Junit) -> Package (.jar) -> JRE (Deploy) -> Artifactory Repo (Nexus)
    
  - Advanced Java (J2EE - Java 2 Enterprise Edition)
    - Web Apps (Spring), Business Trxns, Messaging 
    - src code (*.java) + web content
    - Package (*.java) + web content): .jar or .war or .ear

      src code (web content + *.java) -> Build (Compile) -> Unit Tests (Junit) -> Package (.jar/.war/.ear) -> Deploy to Servers (Tomcat/WL/WAS/JBoss) -> Artifactory Repo (Nexus)

IDE:

  - Eclipse
  - Visual Studio Code
  - Atom
  - Net Beans
  - Sublime Text

Maven Build tool:

  Java Project: (src)
    - Inputs
      - Src Code (src/main)
      - Test Cases (src/test)
      
    - Outputs (target)
      - Compiled code (.java -> .class)
      - Reports of Test Cases (*.xml)
      - Packaged Files (.jar/.war/.ear)
  
Different Build Tools:
  - Maven
  - Ant
  - Gradle

Maven Build Tool:

src code (web content + *.java) 

    -> Build (Compile) 
      $ mvn clean compile

    -> Unit Tests (Junit) 
      $ mvn clean test
      
    -> Package (.jar/.war/.ear)
      $ mvn clean package


Maven:
  - Open Source Build Tool
  - Apache
  - Pre-requisite: Java 
  - Distributed Architecture
  - Build File - pom.xml (PROJECT_HOME)

Setup Maven:
  - Launch the VM/EC2 Instance

    $  sudo yum update -y
    $  sudo hostnamectl set-hostname buildserver
    $  exit
  
  - Install Java
  
    $  java -version
    $  sudo yum search java
    $  sudo yum install -y java-1.8.0-openjdk-devel.x86_64
    $  java -version

  - Setup Maven
      $  cd /opt/
      $  ll -d /opt/
      $  sudo chown -R ec2-user:ec2-user /opt/
      $  ll -d /opt/
      $  ll
      $  wget https://dlcdn.apache.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz
      $  ll
      $  tar -xzf apache-maven-3.8.4-bin.tar.gz
      $  ll
      $  rm -rf apache-maven-3.8.4-bin.tar.gz
      $  ll
      $  mv apache-maven-3.8.4 maven3
      $  ll
      $  cd maven3/
      $  ll
      $  pwd
      $  mvn --version
      $  cd /opt/maven3/bin/
      $  ./mvn --version
      $  env
      $  ls
      $  which ls
      $  /usr/bin/ls
      $  ls
      $  ll /opt/maven3/bin/
      $  mvn --version
      $  export PATH=/opt/maven3/bin/:$PATH
      $  echo $PATH
      $  cd
      $  pwd
      $  mvn --version
      $  exit # Relogin
      $  mvn --version
      $  ll -a
      $  vi .bashrc
      $  source .bashrc
      $  mvn --version
      $  exit # Relogin
      $  mvn -version


Maven Archetype:

Standard alone App:

  $  cd /opt/
  $  ll
  $  mvn archetype:generate -DgroupId=org.rnstech.com -DartifactId=sample-maven -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
  $  ll
  $  cd sample-maven/
  $  ll
  $  cat pom.xml
  $  pwd
  $  ll
  $  ll src/main/
  $  ll src/test/
  $  mvn clean package
  $  ll
  $  ll target/

=================================================================

Maven Build Life Cycles and Phases:
===================================

Life Cycle: sequence of Phases
  - Clean
    - Deleting previous build 'target' 
    - Phases:
      clean
  - Default
    - to perform build activities
    - Phases:
      - compile
      - test
      - package ($PROJECT_HOME/target/*.jar)
      - install (~/.m2/repository)
      - deploy
      - verify 
  - Site (Developers)
    - to generate src code API documentation
    - Phases:
      - site


  $ mvn clean package site

Artifactory Repositories:
  - Dependencies, Libraries

  - Types of Repositories
    - Central
      - https://repo.maven.apache.org
      - Managed by Maven Community
      - Shared Libraries Ex: Junit, Spring, Hybernate, Log4J...
      - We don't have permissions to upload
      - We can download 3rd party libraries
          in pom.xml,
            <dependency>
              <groupdid>
              <artifactid>
              <version>
            </dependency>

            
    - Local
      - System scope
      - ~/.m2/repository
        - Search Sequence:
          - Step1: It verifies in Local Repo. If the dependency is not available in Local, then go to Step2.
          - Step2: It searches the dependency in central repo. 
                    If it is available in central, then that dependency will be downloaded to the Local Repo.
                    Else got to Step3, if Remote repo configured in pom.xml file.
          - Step3: It searches the dependency in Remote repo.
                    If that dependency is not available in Remote repo also, Build will be failed.
                    Else that dependency is available, will be downloaded to the Local Repo.
        - We can change the location of the Local Repo
            Go to $MAVEN_HOME/conf/settings.xml
              <localRepository>/path/to/local/repo</localRepository>

        - We can upload our project specific artifacts to the Local Repo (Backend Module)
            $ mvn clean install
              in pom.xml,
              <groupId>org.rnstech.com</groupId>
              <artifactId>sample-maven</artifactId>
              <version>1.0-SNAPSHOT</version>            
        - We can download local repo artifacts (Frontend Module has to use Backend Module as a dependency)
            in pom.xml,
              <dependency>
              <groupId>org.rnstech.com</groupId>
              <artifactId>sample-maven</artifactId>
              <version>1.0-SNAPSHOT</version> 
              </dependency>

              
    - Remote Repo
      - Client/Org scope
      - Artifacts/Dependencies to Distribute between the developers, between the Env (Dev/Staging/UAT/Prod)

      Ex: Nexus, Artifactory, S3,
          Connection Properties:
            - URL
            - UN/PWD

            - Maven has to be integrated with Remote Repo

      - We can upload the artifact to the Remote Repo

          $ mvn clean deploy

      - - We can download Remote repo artifacts (Frontend Module from Dev1 has to used Backend Module as a dependency from dev2)
          in pom.xml,
            <remote-repo-url>
            <dependency>
            <groupId>org.rnstech.com</groupId>
            <artifactId>sample-maven</artifactId>
            <version>1.0-SNAPSHOT</version> 
            </dependency>
      

  
