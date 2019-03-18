# Setup environment

To start our enviroment go to the home directory and launch

```
$> vagrant up && vagrant ssh mgmt
```

This will boot our VM's and give you shell access to the management VM

If this VM is launched for the first time don't forget to give yourself an ssh public / private keyset

```
$> ssh-keygen
```
Answer all questions asked by the keygen script

Afterward add your public key to all the servers there authorized_hosts file. We have provided a playbook to copy these files
If the file asks for a password enter in vagrant this is the default vagrant password

```
$> ansible-playbook ~/playbooks/ssh.yml --ask-pass
```

If you wish to automate the answering of all ssh known host use this snippet

```
$>  cat inventory.ini | awk '/^[a-z0-9]*$/{if($0 != ""){print $0}}' | xargs ssh-keyscan >> ~/.ssh/known_hosts
```

This snippet of code filters out all servers (only if you use a dns ip's won't work unless you change the regex) and will auto add all keys to the known host

Now we can begin installing all our dependecies to the selected servers
```
$> ansible-playbook ~/playbooks/frontend.yml
$> ansible-playbook ~/playbooks/lb.yml
$> ansible-playbook ~/playbooks/backend.yml
$> ansible-playbook ~/playbooks/db.yml
```

If everything goes according to plan you will need to setup the database

ssh into the database VM

```
$> ssh db
```

From here you will need to connect to the mysql ctl

```
$> mysql -u root -p
```

In the mysql commandline you will need to create a new user (specified in the backend)

```
mysql> GRANT ALL PRIVILEGES ON *.* TO 'user'@'%' IDENTIFIED BY 'user_password' WITH GRANT OPTION;

mysql>FLUSH PRIVILEGES;

mysql> CREATE DATABASE my_database;
```

Now you need to test the mysql connection and if everything worked well you should have a loadbalancer with nginx as webserver with flask as a backend and mysql as the database

to verify the connection go to

[Localhost](http://localhost:8080 "localhost:8080")

This should display a webserver with its ip address and if the database works it should display a title notifing you.