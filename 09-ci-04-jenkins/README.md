# Домашнее задание к занятию 10 «Jenkins» Вахрамеев А.В.

## Подготовка к выполнению

1. Создать два VM: для jenkins-master и jenkins-agent.
2. Установить Jenkins при помощи playbook.
3. Запустить и проверить работоспособность.
4. Сделать первоначальную настройку.

![Screenshot from 2023-12-30 21-54-23](https://github.com/alexnet123/homeworks/assets/75438030/eb5ec801-8b1d-498a-9785-30158aa07b5a)

![Screenshot from 2023-12-30 21-55-50](https://github.com/alexnet123/homeworks/assets/75438030/250b77df-2b29-4b60-a0f0-8e2e5a92eda1)




## Основная часть

1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
```
rm -rf vector-role
git clone https://github.com/alexnet123/vector-role.git
cd vector-role
git checkout temp-branch 
molecule test
```
![Screenshot from 2023-12-31 15-04-23](https://github.com/alexnet123/homeworks/assets/75438030/b036d836-3ff2-4d28-927d-4759bd15bc5a)

2. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
```
pipeline {
    agent any

    stages {
        stage('Cleanup') {
            steps {
                // Удаляем предыдущую копию репозитория, если она существует
                sh 'rm -rf vector-role'
            }
        }

        stage('Clone repository') {
            steps {
                // Клонируем репозиторий
                sh 'git clone https://github.com/alexnet123/vector-role.git'
            }
        }

        stage('Checkout branch') {
            steps {
                // Переходим в каталог репозитория и переключаемся на ветку
                dir('vector-role') {
                    sh 'git checkout temp-branch'
                }
            }
        }

        stage('Run molecule test') {
            steps {
                // Запускаем molecule test
                dir('vector-role') {
                    sh 'molecule test'
                }
            }
        }
    }
}

```

![Screenshot from 2023-12-31 15-40-21](https://github.com/alexnet123/homeworks/assets/75438030/22579f5a-dca6-40e9-9249-2dd8a12f34f0)


3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.

![Screenshot from 2023-12-31 15-53-41](https://github.com/alexnet123/homeworks/assets/75438030/e80f1238-1f4a-4f5d-ba0a-6fad95ddf91d)


4. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.

![Screenshot from 2023-12-31 16-03-26](https://github.com/alexnet123/homeworks/assets/75438030/adcbec70-0499-411d-83e4-4ad6add038ca)


5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).
6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True). По умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.
7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.
8. Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.
9. Сопроводите процесс настройки скриншотами для каждого пункта задания!!

## Необязательная часть

1. Создать скрипт на groovy, который будет собирать все Job, завершившиеся хотя бы раз неуспешно. Добавить скрипт в репозиторий с решением и названием `AllJobFailure.groovy`.
2. Создать Scripted Pipeline так, чтобы он мог сначала запустить через Yandex Cloud CLI необходимое количество инстансов, прописать их в инвентори плейбука и после этого запускать плейбук. Мы должны при нажатии кнопки получить готовую к использованию систему.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
