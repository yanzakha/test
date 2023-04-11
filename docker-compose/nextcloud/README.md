Two containers are created: in the first, the nextcloud application and the apache web server to it, in the second, the database in which all 
information will be written. We forward container's port 80 to host's port 80 to access the web from host. 
We mount volume so that all data remains after the container is restarted. 
In the database container, we attach volume, also so that the data remains after the container is restarted
