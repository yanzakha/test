We create three containers (postgres, zabbix-server, zabbix-web, each depends on the previous ones, until the previous one starts, the next one starts) 
in the same zabbix-net network. 
We forward the zabbix-web container's port 8080 to host's port 80 (because this container listens on 8080 by default). 
For the zabbix-server container, we forward port 10051 from host to container in order to be able to access this host port from zabbix agents on third-party servers. 
We connect volume to the postgres container so that the content of the database is preserved after the restart (you can simply create a volume separately 
and already attach it to all subsequent containers that will be created so that everything is in the same directory)
