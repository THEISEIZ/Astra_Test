Vagrant.configure("2") do |config|
#Название используемого образа 
 config.vm.box = "astra_presale"
#Отключение установки/обновления VBExtensions при запуске Vagrant, так как они были предварительно вшиты в box(образ)
  config.vbguest.auto_update = false


  config.vm.provider "virtualbox" do |v|
#Назначение имени виртуальной машине в VirtualBox
	v.name = "AstraPresale"
#Настройка сетевых адаптеров в VirtualBox. Nic1 - используется для настройки при помощи Vagrant. Nic2 - основной интерфейс, имеющий доступ во внешнюю сеть"
    v.customize ["modifyvm", :id, "--nic1", "nat"]
    v.customize ["modifyvm", :id, "--nic2", "bridged", "--bridgeadapter2", "Realtek PCIe GbE Family Controller"]
  end

#Настройка основного сетевого интерфейса в операционной системе
  config.vm.provision "shell", inline: <<-SHELL
    echo -e 'auto eth1\niface eth1 inet static\naddress 10.77.77.10\nnetmask 255.255.255.0\ngateway 10.77.77.1' | sudo tee /etc/network/interfaces.d/eth1
	systemctl restart networking
  SHELL

#Установка всех необходимых пакетов
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt update 
    sudo apt install -y ansible docker.io python3-pip 
	pip3 install docker 
#Загрузка Dockerfile для сборки контейнера с Apache
	curl -o /home/vagrant/Dockerfile https://raw.githubusercontent.com/THEISEIZ/Astra_Test/Other/Dockerfile 
#Загрузка Ansible playbook с GitHub для развёртывания контейнера Docker с Apache
	curl -o /home/vagrant/apache.yml https://raw.githubusercontent.com/THEISEIZ/Astra_Test/Apache/apache.yml 
    ansible-playbook /home/vagrant/apache.yml 
#Загрузка Ansible playbook с GitHub для развёртывания контейнера Docker с Nginx
	curl -o /home/vagrant/nginx.yml https://raw.githubusercontent.com/THEISEIZ/Astra_Test/Nginx/nginx.yml 
	ansible-playbook /home/vagrant/nginx.yml 
  SHELL
end
