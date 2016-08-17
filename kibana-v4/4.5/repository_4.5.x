
http://packages.elastic.co/kibana/4.5/debian 

Nota : Yep you

wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
then :
echo "deb http://packages.elastic.co/kibana/4.5/debian stable main" | sudo tee -a /etc/apt/sources.list.d/kibana-4.5.x.list
sudo apt-get update
sudo apt-get -y install kibana