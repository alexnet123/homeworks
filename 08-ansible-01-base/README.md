# Домашнее задание к занятию 1 «Введение в Ansible» Вахрамеев А.В.

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.

```
TASK [Print fact] **************************************************************************************************************************
ok: [localhost] => {
    "msg": 12
}

```

2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.

```
TASK [Print fact] **************************************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}

```

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.


Dockerfile для CentOS

```
# Используйте официальный образ CentOS
FROM centos:latest

# Установите необходимое программное обеспечение, например, SSH и sudo
RUN yum -y update && \
    yum -y install openssh-server sudo && \
    yum clean all

# Настройка SSH
RUN ssh-keygen -A

# Создание необходимого каталога для SSH
RUN mkdir /run/sshd

# Дополнительные команды для настройки SSH и создания пользователя ansible
RUN useradd -m -s /bin/bash ansible && \
    echo "ansible:ansible" | chpasswd && \
    echo "ansible ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Открытие порта для SSH
EXPOSE 22

# Запуск SSH сервиса при старте контейнера
CMD ["/usr/sbin/sshd", "-D"]

```

Dockerfile для Debian

```
# Используйте официальный образ Debian
FROM debian:latest

# Установите необходимое программное обеспечение, например, SSH и sudo
RUN apt-get update && \
    apt-get -y install openssh-server sudo && \
    apt-get -y install python3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Настройка SSH
RUN ssh-keygen -A

# Создание необходимого каталога для SSH
RUN mkdir /run/sshd

# Дополнительные команды для настройки SSH и создания пользователя ansible
RUN useradd -m -s /bin/bash ansible && \
    echo "ansible:ansible" | chpasswd && \
    echo "ansible ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Открытие порта для SSH
EXPOSE 22

# Запуск SSH сервиса при старте контейнера
CMD ["/usr/sbin/sshd", "-D"]
```

Сборка и Запуск Контейнеров

Сборка Образов:
```
Для CentOS: docker build -f Dockerfile-centos -t my-centos .
Для Debian: docker build -f Dockerfile-debian -t my-debian .
```
Запуск Контейнеров:
```
Для CentOS: docker run -d -P --name my-centos-container my-centos
Для Debian: docker run -d -P --name my-debian-container my-debian
```

4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.

![Screenshot from 2023-11-25 22-47-38](https://github.com/alexnet123/homeworks/assets/75438030/6ef32fd9-f2c3-4c3e-ba91-d03b83b8b62d)


5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.
6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.

![Screenshot from 2023-11-25 22-50-23](https://github.com/alexnet123/homeworks/assets/75438030/6189f68b-20e3-4cc0-99d0-c1206c44d87f)

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.

```
root@debian:/home/alex/test/homeworks/08-ansible-01-base/playbook# ansible-vault encrypt group_vars/
all/ deb/ el/  
root@debian:/home/alex/test/homeworks/08-ansible-01-base/playbook# ansible-vault encrypt group_vars/deb/examp.yml 
New Vault password: 
Confirm New Vault password: 
Encryption successful
root@debian:/home/alex/test/homeworks/08-ansible-01-base/playbook# ansible-vault encrypt group_vars/el/examp.yml 
New Vault password: 
Confirm New Vault password: 
Encryption successful


```

8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.

![Screenshot from 2023-11-25 22-57-37](https://github.com/alexnet123/homeworks/assets/75438030/4f23a595-c062-42a2-9528-ecf0e36e760d)

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.

```
root@debian:/home/alex/test/homeworks/08-ansible-01-base/playbook# ansible-doc -t connection -l
ansible.builtin.local          execute on controller                                                                                   
ansible.builtin.paramiko_ssh   Run tasks via Python SSH (paramiko)                                                                     
ansible.builtin.psrp           Run tasks over Microsoft PowerShell Remoting Protocol                                                   
ansible.builtin.ssh            connect via SSH client binary                                                                           
ansible.builtin.winrm          Run tasks over Microsoft's WinRM                                                                        
ansible.netcommon.grpc         Provides a persistent connection using the gRPC protocol                                                
ansible.netcommon.httpapi      Use httpapi to run command on network appliances                                                        
ansible.netcommon.libssh       Run tasks using libssh for ssh connection                                                               
ansible.netcommon.netconf      Provides a persistent connection using the netconf protocol                                             
ansible.netcommon.network_cli  Use network_cli to run command on network appliances                                                    
ansible.netcommon.persistent   Use a persistent unix socket for connection                                                             
community.aws.aws_ssm          connect to EC2 instances via AWS Systems Manager                                                        
community.docker.docker        Run tasks in docker containers                                                                          
community.docker.docker_api    Run tasks in docker containers                                                                          
community.docker.nsenter       execute on host running controller container                                                            
community.general.chroot       Interact with local chroot                                                                              
community.general.funcd        Use funcd to connect to target                                                                          
community.general.iocage       Run tasks in iocage jails                                                                               
community.general.jail         Run tasks in jails                                                                                      
community.general.lxc          Run tasks in lxc containers via lxc python library                                                      
community.general.lxd          Run tasks in lxc containers via lxc CLI                                                                 
community.general.qubes        Interact with an existing QubesOS AppVM                                                                 
community.general.saltstack    Allow ansible to piggyback on salt minions                                                              
community.general.zone         Run tasks in a zone instance                                                                            
community.libvirt.libvirt_lxc  Run tasks in lxc containers via libvirt                                                                 
community.libvirt.libvirt_qemu Run tasks on libvirt/qemu virtual machines                                                              
community.okd.oc               Execute tasks in pods running on OpenShift                                                              
community.vmware.vmware_tools  Execute tasks inside a VM via VMware Tools                                                              
containers.podman.buildah      Interact with an existing buildah container                                                             
containers.podman.podman       Interact with an existing podman container                                                              
kubernetes.core.kubectl        Execute tasks in pods running on Kubernetes

```

```
root@debian:/home/alex/test/homeworks/08-ansible-01-base/playbook# ansible-doc -t connection local
> ANSIBLE.BUILTIN.LOCAL    (/usr/local/lib/python3.11/dist-packages/ansible/plugins/connection/local.py)

        This connection plugin allows ansible to execute tasks on the Ansible 'controller' instead of on a
        remote host.

ADDED IN: historical

OPTIONS (= is mandatory):

- pipelining
        Pipelining reduces the number of connection operations required to execute a module on the remote
        server, by executing many Ansible modules without actual file transfers.
        This can result in a very significant performance improvement when enabled.
        However this can conflict with privilege escalation (become). For example, when using sudo operations
        you must first disable 'requiretty' in the sudoers file for the target hosts, which is why this feature
        is disabled by default.
        set_via:
          env:
          - name: ANSIBLE_PIPELINING
          ini:
          - key: pipelining
            section: defaults
          - key: pipelining
            section: connection
          vars:
          - name: ansible_pipelining
        default: false
        type: boolean


NOTES:
      * The remote user is ignored, the user with which the ansible CLI was executed is used instead.


AUTHOR: ansible (@core)

NAME: local


```

10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.

![Screenshot from 2023-11-25 23-15-42](https://github.com/alexnet123/homeworks/assets/75438030/85ba4583-27c4-4b1d-8458-9602497cf1d8)


12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.
13. Предоставьте скриншоты результатов запуска команд.

`данные в репозитории`

---

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).
5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
6. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий.

