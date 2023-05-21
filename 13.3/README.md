# Домашнее задание к занятию "`13.3. «Защита сети»`" - `Вахрамеев А.В.`

------

### Подготовка к выполнению заданий

1. Подготовка защищаемой системы:

- установите **Suricata**,
- установите **Fail2Ban**.

2. Подготовка системы злоумышленника: установите **nmap** и **thc-hydra** либо скачайте и установите **Kali linux**.

Обе системы должны находится в одной подсети.

------

### Задание 1

Проведите разведку системы и определите, какие сетевые службы запущены на защищаемой системе:

`Ответ:`

Атаку проводил с ip 10.128.0.20

**sudo nmap -sA < ip-адрес >**

```
Без логов

```

**sudo nmap -sT < ip-адрес >**

```
suricata

03/11/2023-15:04:46.778293  [**] [1:2010937:3] ET SCAN Suspicious inbound to mySQL port 3306 [**] [Classification: Potentially Bad Traffic] [Priority: 2] {TCP} 10.128.0.8:58112 -> 10.128.0.20:3306
03/11/2023-15:04:46.796113  [**] [1:2010939:3] ET SCAN Suspicious inbound to PostgreSQL port 5432 [**] [Classification: Potentially Bad Traffic] [Priority: 2] {TCP} 10.128.0.8:58778 -> 10.128.0.20:5432
03/11/2023-15:04:46.805840  [**] [1:2010936:3] ET SCAN Suspicious inbound to Oracle SQL port 1521 [**] [Classification: Potentially Bad Traffic] [Priority: 2] {TCP} 10.128.0.8:48228 -> 10.128.0.20:1521
03/11/2023-15:04:46.806556  [**] [1:2010935:3] ET SCAN Suspicious inbound to MSSQL port 1433 [**] [Classification: Potentially Bad Traffic] [Priority: 2] {TCP} 10.128.0.8:60288 -> 10.128.0.20:1433

```
**sudo nmap -sS < ip-адрес >**

```
suricata

03/11/2023-15:05:25.529611  [**] [1:2010937:3] ET SCAN Suspicious inbound to mySQL port 3306 [**] [Classification: Potentially Bad Traffic] [Priority: 2] {TCP} 10.128.0.8:49611 -> 10.128.0.20:3306
03/11/2023-15:05:25.533669  [**] [1:2010935:3] ET SCAN Suspicious inbound to MSSQL port 1433 [**] [Classification: Potentially Bad Traffic] [Priority: 2] {TCP} 10.128.0.8:49611 -> 10.128.0.20:1433
03/11/2023-15:05:25.533965  [**] [1:2010939:3] ET SCAN Suspicious inbound to PostgreSQL port 5432 [**] [Classification: Potentially Bad Traffic] [Priority: 2] {TCP} 10.128.0.8:49611 -> 10.128.0.20:5432
03/11/2023-15:05:25.541917  [**] [1:2010936:3] ET SCAN Suspicious inbound to  [**] [Classification: Potentially Bad Traffic] [Priority: 2] {TCP} 10.128.0.8:49611 -> 10.128.0.20:1521
03/11/2023-15:05:25.551953  [**] [1:2002911:6] ET SCAN Potential VNC Scan 5900-5920 [**] [Classification: Attempted Information Leak] [Priority: 2] {TCP} 10.128.0.8:49611 -> 10.128.0.20:5915
03/11/2023-15:05:25.568914  [**] [1:2002910:6] ET SCAN Potential VNC Scan 5800-5820 [**] [Classification: Attempted Information Leak] [Priority: 2] {TCP} 10.128.0.8:49611 -> 10.128.0.20:5811

```

**sudo nmap -sV < ip-адрес >**

```
suricata

03/11/2023-15:06:08.537997  [**] [1:2010937:3] ET SCAN Suspicious inbound to mySQL port 3306 [**] [Classification: Potentially Bad Traffic] [Priority: 2] {TCP} 10.128.0.8:64706 -> 10.128.0.20:3306
03/11/2023-15:06:08.545162  [**] [1:2010936:3] ET SCAN Suspicious inbound to Oracle SQL port 1521 [**] [Classification: Potentially Bad Traffic] [Priority: 2] {TCP} 10.128.0.8:64706 -> 10.128.0.20:1521
03/11/2023-15:06:08.545731  [**] [1:2010939:3] ET SCAN Suspicious inbound to PostgreSQL port 5432 [**] [Classification: Potentially Bad Traffic] [Priority: 2] {TCP} 10.128.0.8:64706 -> 10.128.0.20:5432
03/11/2023-15:06:08.574418  [**] [1:2010935:3] ET SCAN Suspicious inbound to MSSQL port 1433 [**] [Classification: Potentially Bad Traffic] [Priority: 2] {TCP} 10.128.0.8:64706 -> 10.128.0.20:1433

fail2ban

Mar 11 15:06:08 suricata sshd[3669]: error: kex_exchange_identification: Connection closed by remote host
Mar 11 15:06:08 suricata sshd[3669]: Connection closed by 10.128.0.8 port 39718

```

Журналы показывают подозрительный входящий трафик на сервере с IP-адресом 10.128.0.20. В частности, существуют предупреждения о трафике на портах, обычно используемых серверами баз данных: MySQL (порт 3306), Oracle SQL (порт 1521), PostgreSQL (порт 5432),Oracle SQL port 1521, VNC и MSSQL (порт 1433). Оповещения указывают, что трафик потенциально плохой, а приоритет оповещений оценивается как 2.

Кроме того, в журнале fail2ban есть сообщение об ошибке, указывающее на то, что соединение с сервером SSH было закрыто удаленным хостом с IP-адресом 10.128.0.8, что соответствует IP-адресу источника подозрительного трафика, обнаруженного Suricata. Это говорит о том, что удаленный хост попытался подключиться к SSH-серверу, но не смог установить соединение.

------

### Задание 2

Проведите атаку на подбор пароля для службы SSH:

**hydra -L users.txt -P pass.txt < ip-адрес > ssh**

1. Настройка **hydra**: 
 
 - создайте два файла: **users.txt** и **pass.txt**;
 - в каждой строчке первого файла должны быть имена пользователей, второго — пароли. В нашем случае это могут быть случайные строки, но ради эксперимента можете добавить имя и пароль существующего пользователя.

Дополнительная информация по **hydra**: https://kali.tools/?p=1847.

2. Включение защиты SSH для Fail2Ban:

-  открыть файл /etc/fail2ban/jail.conf,
-  найти секцию **ssh**,
-  установить **enabled**  в **true**.


Дополнительная информация по **Fail2Ban**:https://putty.org.ru/articles/fail2ban-ssh.html.

`Ответ:`

`f2ban`

```
Mar 11 16:04:47 suricata sshd[3905]: Failed password for invalid user ftp from 1.4.188.240 port 35347 ssh2
Mar 11 16:04:48 suricata sshd[3905]: pam_unix(sshd:auth): check pass; user unknown
Mar 11 16:04:48 suricata sshd[3909]: Failed password for root from 10.128.0.8 port 35568 ssh2
Mar 11 16:04:48 suricata sshd[3911]: Failed password for root from 10.128.0.8 port 35578 ssh2
Mar 11 16:04:48 suricata sshd[3913]: Failed password for root from 10.128.0.8 port 35590 ssh2
Mar 11 16:04:48 suricata sshd[3915]: Failed password for root from 10.128.0.8 port 35592 ssh2
Mar 11 16:04:50 suricata sshd[3905]: Failed password for invalid user ftp from 1.4.188.240 port 35347 ssh2
Mar 11 16:04:51 suricata sshd[3909]: Failed password for root from 10.128.0.8 port 35568 ssh2
Mar 11 16:04:51 suricata sshd[3911]: Failed password for root from 10.128.0.8 port 35578 ssh2
Mar 11 16:04:51 suricata sshd[3913]: Failed password for root from 10.128.0.8 port 35590 ssh2
Mar 11 16:04:51 suricata sshd[3915]: Failed password for root from 10.128.0.8 port 35592 ssh2

```

`suricata`

```
03/11/2023-16:03:12.426837  [**] [1:2001219:20] ET SCAN Potential SSH Scan [**] [Classification: Attempted Information Leak] [Priority: 2] {TCP} 10.128.0.8:44970 -> 10.128.0.20:22
03/11/2023-16:03:12.426837  [**] [1:2003068:7] ET SCAN Potential SSH Scan OUTBOUND [**] [Classification: Attempted Information Leak] [Priority: 2] {TCP} 10.128.0.8:44970 -> 10.128.0.20:22
03/11/2023-16:04:46.469424  [**] [1:2003068:7] ET SCAN Potential SSH Scan OUTBOUND [**] [Classification: Attempted Information Leak] [Priority: 2] {TCP} 10.128.0.8:35568 -> 10.128.0.20:22

```


