# Домашнее задание к занятию 13.1. «Уязвимости и атаки на информационные системы» - `Вахрамеев А.В.`



### Задание 1

Скачайте и установите виртуальную машину Metasploitable: https://sourceforge.net/projects/metasploitable/.

Это типовая ОС для экспериментов в области информационной безопасности, с которой следует начать при анализе уязвимостей.

Просканируйте эту виртуальную машину, используя **nmap**.

Попробуйте найти уязвимости, которым подвержена эта виртуальная машина.

Сами уязвимости можно поискать на сайте https://www.exploit-db.com/.

Для этого нужно в поиске ввести название сетевой службы, обнаруженной на атакуемой машине, и выбрать подходящие по версии уязвимости.

Ответьте на следующие вопросы:

- Какие сетевые службы в ней разрешены?

`Ответ:`

```
Scanning 192.168.1.36 [1000 ports]                           
Discovered open port 23/tcp on 192.168.1.36     -  Telnet (23/tcp) 
Discovered open port 80/tcp on 192.168.1.36     -  HTTP (80/tcp) 
Discovered open port 111/tcp on 192.168.1.36    -  RPCbind (111/tcp)  
Discovered open port 5900/tcp on 192.168.1.36   -  Virtual Network Computing (VNC) (5900/tcp)   
Discovered open port 139/tcp on 192.168.1.36    -  NetBIOS Session Service (139/tcp)  
Discovered open port 3306/tcp on 192.168.1.36   -  MySQL Database (3306/tcp)   
Discovered open port 21/tcp on 192.168.1.36     -  FTP (21/tcp) 
Discovered open port 22/tcp on 192.168.1.36     -  SSH (22/tcp) 
Discovered open port 53/tcp on 192.168.1.36     -  Domain Name System (DNS) (53/tcp) 
Discovered open port 25/tcp on 192.168.1.36     -  Simple Mail Transfer Protocol (SMTP) (25/tcp) 
Discovered open port 445/tcp on 192.168.1.36    -  Microsoft-DS (445/tcp)  
Discovered open port 1099/tcp on 192.168.1.36   -  Remote Method Invocation (RMI) (1099/tcp)   
Discovered open port 8180/tcp on 192.168.1.36   -  Apache Tomcat (8180/tcp)   
Discovered open port 2049/tcp on 192.168.1.36   -  Network File System (NFS) (2049/tcp)   
Discovered open port 1524/tcp on 192.168.1.36   -  Supportsoft Listener (1524/tcp)   
Discovered open port 513/tcp on 192.168.1.36    -  Remote Shell (rsh) (513/tcp)  
Discovered open port 8009/tcp on 192.168.1.36   -  Apache JServ Protocol (AJP) (8009/tcp)   
Discovered open port 2121/tcp on 192.168.1.36   -  FTP (Control) (2121/tcp)   
Discovered open port 514/tcp on 192.168.1.36    -  Remote Shell (rsh) (514/tcp)  
Discovered open port 6667/tcp on 192.168.1.36   -  Internet Relay Chat (IRC) (6667/tcp)   
Discovered open port 6000/tcp on 192.168.1.36   -  X11 (6000/tcp)   
Discovered open port 5432/tcp on 192.168.1.36   -  PostgreSQL Database (5432/tcp)   
Discovered open port 512/tcp on 192.168.1.36    -  Remote Process Execution (512/tcp)                 


```
- Какие уязвимости были вами обнаружены? (список со ссылками: достаточно трёх уязвимостей)

`Ответ:`

`21/tcp   open  ftp         vsftpd 2.3.4`

![Снимок экрана от 2023-03-06 15-01-30](https://user-images.githubusercontent.com/75438030/223105196-e953ee8c-087c-4fb9-bfcb-e4cf424e2a63.png)

![Снимок экрана от 2023-03-06 15-01-20](https://user-images.githubusercontent.com/75438030/223105227-8d15e93c-bc49-4b36-9303-d84cfcb97c56.png)

`53/tcp   open  domain      ISC BIND 9.4.2`

![Снимок экрана от 2023-03-06 15-09-38](https://user-images.githubusercontent.com/75438030/223106635-2e74bbb5-13c0-4edd-b68f-d95ff890bc61.png)

![Снимок экрана от 2023-03-06 15-09-23](https://user-images.githubusercontent.com/75438030/223106648-9a1a53ef-cbcc-4ae0-b5f5-9ced698040f6.png)

`2121/tcp open  ftp         ProFTPD 1.3.1`

![Снимок экрана от 2023-03-06 15-30-21](https://user-images.githubusercontent.com/75438030/223110975-744df2fb-0c49-4af4-a5e2-680df548f765.png)


### Задание 2

Проведите сканирование Metasploitable в режимах SYN, FIN, Xmas, UDP.

Запишите сеансы сканирования в Wireshark.

Ответьте на следующие вопросы:

- Чем отличаются эти режимы сканирования с точки зрения сетевого трафика?
- Как отвечает сервер?

`Ответ:`

`Пример сбора дампа трафика в режиме SYN`

`nmap -sS 192.168.1.36`  

![Снимок экрана от 2023-03-06 15-45-52](https://user-images.githubusercontent.com/75438030/223114379-aecabbb3-b0c2-4744-aec2-58f11e31046b.png)

![Снимок экрана от 2023-03-06 15-46-00](https://user-images.githubusercontent.com/75438030/223114396-b9709d1e-e450-40ab-94f9-67e0fa588f88.png)

FIN

`nmap -sF 192.168.1.36`

Xmas

`nmap -sX 192.168.1.36`

UDP

`nmap -sU 192.168.1.36`





