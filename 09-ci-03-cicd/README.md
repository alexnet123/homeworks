# Домашнее задание к занятию 9 «Процессы CI/CD» Вахрамеев А.В.

## Подготовка к выполнению

1. Создайте два VM в Yandex Cloud с параметрами: 2CPU 4RAM Centos7 (остальное по минимальным требованиям).
2. Пропишите в [inventory](./infrastructure/inventory/cicd/hosts.yml) [playbook](./infrastructure/site.yml) созданные хосты.
3. Добавьте в [files](./infrastructure/files/) файл со своим публичным ключом (id_rsa.pub). Если ключ называется иначе — найдите таску в плейбуке, которая использует id_rsa.pub имя, и исправьте на своё.
4. Запустите playbook, ожидайте успешного завершения.

![Screenshot from 2024-01-04 16-15-27](https://github.com/alexnet123/homeworks/assets/75438030/28998ab7-49ae-4800-a4a0-b111a682d1a9)

5. Проверьте готовность SonarQube через [браузер](http://localhost:9000).
6. Зайдите под admin\admin, поменяйте пароль на свой.

![Screenshot from 2024-01-04 16-17-06](https://github.com/alexnet123/homeworks/assets/75438030/0051ee4d-f00c-4119-a74f-1709a8461710)


7.  Проверьте готовность Nexus через [бразуер](http://localhost:8081).
8. Подключитесь под admin\admin123, поменяйте пароль, сохраните анонимный доступ.

![Screenshot from 2024-01-04 16-19-57](https://github.com/alexnet123/homeworks/assets/75438030/e85f4c71-2d33-4697-b918-35283ae0172e)


## Знакомоство с SonarQube

### Основная часть

1. Создайте новый проект, название произвольное.
2. Скачайте пакет sonar-scanner, который вам предлагает скачать SonarQube.
3. Сделайте так, чтобы binary был доступен через вызов в shell (или поменяйте переменную PATH, или любой другой, удобный вам способ).
4. Проверьте `sonar-scanner --version`.

![Screenshot from 2024-01-04 16-56-50](https://github.com/alexnet123/homeworks/assets/75438030/dbbc4d3b-5af2-4402-8c28-e0a9a63b8507)

5. Запустите анализатор против кода из директории [example](./example) с дополнительным ключом `-Dsonar.coverage.exclusions=fail.py`.
6. Посмотрите результат в интерфейсе.

![Screenshot from 2024-01-04 16-59-41](https://github.com/alexnet123/homeworks/assets/75438030/ecf9cd27-4427-4fa3-bdef-935eabf9d779)


7. Исправьте ошибки, которые он выявил, включая warnings.
8. Запустите анализатор повторно — проверьте, что QG пройдены успешно.
9. Сделайте скриншот успешного прохождения анализа, приложите к решению ДЗ.

![Screenshot from 2024-01-04 17-01-43](https://github.com/alexnet123/homeworks/assets/75438030/a69583ba-a5c2-4129-8a09-12ec6b238e27)


## Знакомство с Nexus

### Основная часть

1. В репозиторий `maven-public` загрузите артефакт с GAV-параметрами:

 *    groupId: netology;
 *    artifactId: java;
 *    version: 8_282;
 *    classifier: distrib;
 *    type: tar.gz.
   
2. В него же загрузите такой же артефакт, но с version: 8_102.
3. Проверьте, что все файлы загрузились успешно.
4. В ответе пришлите файл `maven-metadata.xml` для этого артефекта.

![Screenshot from 2024-01-04 20-30-06](https://github.com/alexnet123/homeworks/assets/75438030/a6d8257c-637b-41e3-87d7-b1e5419f65e2)


### Знакомство с Maven

### Подготовка к выполнению

1. Скачайте дистрибутив с [maven](https://maven.apache.org/download.cgi).
2. Разархивируйте, сделайте так, чтобы binary был доступен через вызов в shell (или поменяйте переменную PATH, или любой другой, удобный вам способ).
3. Удалите из `apache-maven-<version>/conf/settings.xml` упоминание о правиле, отвергающем HTTP- соединение — раздел mirrors —> id: my-repository-http-unblocker.
4. Проверьте `mvn --version`.

```
root@debian:~# mvn --version
Apache Maven 3.9.6 (bc0240f3c744dd6b6ec2920b3cd08dcc295161ae)
Maven home: /opt/apache-maven-3.9.6
Java version: 17.0.9, vendor: Debian, runtime: /usr/lib/jvm/java-17-openjdk-amd64
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "6.1.0-16-amd64", arch: "amd64", family: "unix"
root@debian:~# 

```

5. Заберите директорию [mvn](./mvn) с pom.

### Основная часть

1. Поменяйте в `pom.xml` блок с зависимостями под ваш артефакт из первого пункта задания для Nexus (java с версией 8_282).
2. Запустите команду `mvn package` в директории с `pom.xml`, ожидайте успешного окончания.
3. Проверьте директорию `~/.m2/repository/`, найдите ваш артефакт.
4. В ответе пришлите исправленный файл `pom.xml`.

```
root@debian:/home/alex/test/homeworks/09-ci-03-cicd/mvn# ls -al /root/.m2/repository/
total 16
drwxr-xr-x 4 root root 4096 Jan  4 21:08 .
drwxr-xr-x 3 root root 4096 Jan  4 21:08 ..
drwxr-xr-x 3 root root 4096 Jan  4 21:08 netology
drwxr-xr-x 4 root root 4096 Jan  4 21:08 org
root@debian:/home/alex/test/homeworks/09-ci-03-cicd/mvn# ls -al /root/.m2/repository/netology/
total 12
drwxr-xr-x 3 root root 4096 Jan  4 21:08 .
drwxr-xr-x 4 root root 4096 Jan  4 21:08 ..
drwxr-xr-x 3 root root 4096 Jan  4 21:08 java
root@debian:/home/alex/test/homeworks/09-ci-03-cicd/mvn# 



```

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
