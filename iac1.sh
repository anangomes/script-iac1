#!/bin/bash

echo "Criando diretórios"

sudo mkdir /publico
sudo mkdir /con
sudo mkdir /ven
sudo mkdir /sec

echo "Criando os grupos de usuários"

sudo groupadd GRP_CON
sudo groupadd GRP_VEN
sudo groupadd GRP_SEC

echo "Criando usuários"

sudo useradd -g GRP_CON meredith
sudo useradd -g GRP_CON oscar
sudo useradd -g GRP_CON angela

sudo useradd -g GRP_VEN jim
sudo useradd -g GRP_VEN dwight
sudo useradd -g GRP_VEN phyllis

sudo useradd -g GRP_SEC pam
sudo useradd -g GRP_SEC erin
sudo useradd -g GRP_SEC gabe

# Definição de senha padrão criptografada para todos os usuários
SENHA=$(mkpasswd -m sha-512 123)
echo "meredith:$SENHA" | sudo chpasswd
echo "oscar:$SENHA" | sudo chpasswd
echo "angela:$SENHA" | sudo chpasswd
echo "jim:$SENHA" | sudo chpasswd
echo "dwight:$SENHA" | sudo chpasswd
echo "phyllis:$SENHA" | sudo chpasswd
echo "pam:$SENHA" | sudo chpasswd
echo "erin:$SENHA" | sudo chpasswd
echo "gabe:$SENHA" | sudo chpasswd


echo "Definindo proprietários e permissões dos diretórios"

sudo chown root /publico
sudo chown root /con
sudo chown root /ven
sudo chown root /sec

sudo chmod 777 /publico
sudo chmod 770 /con
sudo chmod 770 /ven
sudo chmod 770 /sec

sudo chgrp GRP_CON /con
sudo chgrp GRP_VEN /ven
sudo chgrp GRP_SEC /sec

sudo chmod 770 /con
sudo chmod 770 /ven
sudo chmod 770 /sec

echo "Definindo permissões de acesso dos usuários"

sudo chgrp GRP_CON /publico
sudo chgrp GRP_VEN /publico
sudo chgrp GRP_SEC /publico

sudo chmod 777 /publico
sudo chmod 770 /con
sudo chmod 770 /ven
sudo chmod 770 /sec

echo "Definindo as restrições de acesso aos diretórios"

sudo setfacl -m g:GRP_CON:rwx /con
sudo setfacl -m g:GRP_VEN:rwx /ven
sudo setfacl -m g:GRP_SEC:rwx /sec

sudo setfacl -m g:GRP_CON:--- /ven
sudo setfacl -m g:GRP_CON:--- /sec

sudo setfacl -m g:GRP_VEN:--- /con
sudo setfacl -m g:GRP_VEN:--- /sec

sudo setfacl -m g:GRP_SEC:--- /con
sudo setfacl -m g:GRP_SEC:--- /ven

chmod +x "$0"

echo "Procedimento finalizado"
