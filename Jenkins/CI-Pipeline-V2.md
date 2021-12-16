# Step-1:
  - Configure Master-Slave Nodes. Use build activities on ‘Build Server’

# Step-2:
  – Configure Maven Tool in the Global Tool Configuration section.
  – Install Build Pipeline Plugin for Up/Down Stream Jobs

# Step-3: 

Pipeline Jobs:

1. Pull the code from repository
2. Static analysis
3. Packaging App

# Job#1: Static Analysis:
——————————–---------------

Install Plugins:
  – Clone Workspace for SCM
  – Install ‘cobertura plugin

— Git Integration

— Build Section:
  add ‘cobertura:cobertura’ command in the Maven trigger section

— Post Build Action:
1) Add publishing cobertura report
2) Archive Clone Workspace for SCM
  – Files to include in cloned workspace – **/*
3) Build Other Project –
  – ‘Package-App’
4) Email Notification

# Job#2: Package-App:
——------------———————–

— Source Code Mgmt:
  – with Clone Workspace SCM plugin

— Build Section
  – Maven trigger – clean package

— Post build section Add
1) ‘Archive the Artifacts’ **/*.war
2) ‘Publish Juint Test Result Report’ – **/target/surefire-reports/*.xml
3) Email Notification


# Configure the Tomcat:
In the tomcat-users.xml file first add the roles and restart Tomcat

<role rolename=”manager-script”/>
<role rolename=”admin-gui”/>
<user username=”tomcat” password=”welcome” roles=”manager-script,admin-gui”/>

# Job#3: Deploy-to-Staging:
----------------------------
— Install the Plugins
  – copy artifact
  – deploy to container

— Build Trigger Section
  – Build after other Projects Built
    —- Package-App

— Build Section:
– Copy artifacts from another project
  —- Project Name – Package-App
  —- Artifacts to copy – **/*.war

— Post-build Actions:
  – Deploy war/ear to container
    —- WAR/EAR files – **/*.war
    —- Containers-Tomcat9.x
      —- Credentials – Tomcat UN and PWD
      —- Tomcat URL – http://IP:8080

– ‘Build other Project’ Integration-Testing

# Job#4: ‘Integration-Testing’:
--------------------------------

— Source Code Mgmt:
  —- with Clone Workspace SCM plugin

— Build Section:
  —- Maven Targets: ‘clean verify’
