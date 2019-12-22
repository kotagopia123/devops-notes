APP_NAME=webapp
APP_VERSION=1.0
export TOMCAT_HOME=/workspace/appServer
cd $TOMCAT_HOME/bin
./shutdown.sh
sleep 20
cd $TOMCAT_HOME/webapps
mv $APP_NAME.war /tmp/
cd $TOMCAT_HOME/work
rm -rf *
cd $TOMCAT_HOME/temp
rm -rf *
cd /tmp
wget http://192.168.10.10:8090/nexus/content/repositories/releases/com/rns/simpleweb/$APP_NAME/$APP_VERSION/$APP_NAME-$APP_VERSION.war
mv $APP_NAME-$APP_VERSION.war $TOMCAT_HOME/webapps/$APP_NAME.war
cd $TOMCAT_HOME/bin
./startup.sh
sleep 20
curl http://192.168.10.12:8080/$APP_NAME
if [ $? -eq 0 ]
then
	echo "Application Hosted Successfully"
else 
	echo "Application Hosting Failed"
fi
