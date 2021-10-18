# Build Server:
	- Java version - 1.8

# Step-1: Compile-Src-Code:
	- Inputs:
		- Src code 
		- Integrating with Git Hub Repo
			- URL
			- Credentials
			- Branch

	- Build:
		Pre-requisite:
			- Configure the Maven Tool at Global
				- Name - Maven3
				  Home - Install Automatically
				  Version - 3.8.3
		Step:
			- Invoke top level Maven Targets
				- Maven Version - Select Tool (Maven3)
				- Goals - 'clean compile'

	- Post Build:
		- No Publish
		- Archive for CLone Workspace for SCM
			- **/*
			- target/
			- latest completed buils
			- Gzip with tar
		- Build other Projects
			- Pre-Deployment-Testing


# Step-2: Pre-Deployment-Testing:
	- Pre-requisite:
		Plugin:
			- Clone workspace SCM

	-Src Code:
		- Clone Workspace
			- Compile-Src-Code
			- Most Recent Completed Build

	- Build Step:
		- Invoke top level Maven Targets
			Maven Version - Tool Maven3
			Goal - clean test

	- Post Build:
		- Publish Junit Test Result Reports
			- target/surefire-reports/*.xml
		- Build other Projects
			- Packaging-Application

# Step-3: Packaging-Application
	
	-Src Code:
		- Clone Workspace
			- Compile-Src-Code
			- Most Recent Completed Build

	- Build Step:
		-  Invoke top level Maven Targets
			Maven Version - Tool Maven3
			Goal - clean package/deploy

	- Post Build Action:
		- Publish the Artifacts
			- Archive the Artifacts
				- **/*.war
		- Build other Projects
			- Deploy-to-Server


	Upload artifacts to Remote Repo (Nexus):
		- Login to Build Server
			- Tomcat 9.0 version install it
			- edit context.xml file of the manager app and comment the remote access
			- Access the Nexus Server URL
				- Snap Shot URL
				- Release URL
				- UN/PWD

			- Go to src code of the project and edit the pom.xml and add distribution Management element
				<distributionManagement>

			- Add the credentials of nexus in MAVEN_HOME 
				vi /home/centos/jenkins/tools/hudson.tasks.Maven_MavenInstallation/Maven3/conf/settings.xml

		- clean deploy


# Step-4: Deploy-to-Server:

	Pre-requisite:
		- Add the following content in tomcat-users.xml
			<role rolename="manager-gui"/>
			<user username="tomcat" password="welcome" roles="manager-gui,manager-script"/>

	Plugin Pre-requisites:
		- Copy Artifact
		- Deploy to container

	- Build Steps
		- Copy artifact from Other Project
			- Packaging-Application
			- Latest Succeeful Build
			- **/*.war (target/*.war)

	- Post Build 
		- Deploy war/ear to a container
			- War/ear files - target/*.war
			- Context Path - webapp
			- Container - Tomcat9.x
				- UN/PWD
				- URL

		- Build other Projects
			- Post-Deployment-Testing


# Step-4: Post-Deployment-Testing:
	
	-Src Code:
		- Clone Workspace
			- Compile-Src-Code
			- Most Recent Completed Build

	- Build Step:
		-  Invoke top level Maven Targets
			Maven Version - Tool Maven3
			Goal - clean verify
