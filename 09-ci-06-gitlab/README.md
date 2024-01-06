# Домашнее задание к занятию 12 «GitLab» Вахрамеев А.В.

## Подготовка к выполнению


1. Или подготовьте к работе Managed GitLab от yandex cloud [по инструкции](https://cloud.yandex.ru/docs/managed-gitlab/operations/instance/instance-create) .
Или создайте виртуальную машину из публичного образа [по инструкции](https://cloud.yandex.ru/marketplace/products/yc/gitlab ) .

![Screenshot from 2024-01-06 13-36-33](https://github.com/alexnet123/homeworks/assets/75438030/7dbeb391-91e5-4e09-861f-fd015bd8b6ed)

2. Создайте виртуальную машину и установите на нее gitlab runner, подключите к вашему серверу gitlab  [по инструкции](https://docs.gitlab.com/runner/install/linux-repository.html) .

![Screenshot from 2024-01-06 14-00-54](https://github.com/alexnet123/homeworks/assets/75438030/ba0ee6f5-103f-483a-bddb-633afd2dc029)


3. (* Необязательное задание повышенной сложности. )  Если вы уже знакомы с k8s попробуйте выполнить задание, запустив gitlab server и gitlab runner в k8s  [по инструкции](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/gitlab-containers). 

4. Создайте свой новый проект.
5. Создайте новый репозиторий в GitLab, наполните его [файлами](./repository).
6. Проект должен быть публичным, остальные настройки по желанию.

![Screenshot from 2024-01-06 13-38-04](https://github.com/alexnet123/homeworks/assets/75438030/b34e62f8-e08a-4ff2-9029-0f76b8521588)


## Основная часть



### DevOps

В репозитории содержится код проекта на Python. Проект — RESTful API сервис. Ваша задача — автоматизировать сборку образа с выполнением python-скрипта:

1. Образ собирается на основе [centos:7](https://hub.docker.com/_/centos?tab=tags&page=1&ordering=last_updated).
2. Python версии не ниже 3.7.
3. Установлены зависимости: `flask` `flask-jsonpify` `flask-restful`.
4. Создана директория `/python_api`.
5. Скрипт из репозитория размещён в /python_api.
6. Точка вызова: запуск скрипта.
7. При комите в любую ветку должен собираться docker image с форматом имени hello:gitlab-$CI_COMMIT_SHORT_SHA . Образ должен быть выложен в Gitlab registry или yandex registry.   

![Screenshot from 2024-01-06 16-55-16](https://github.com/alexnet123/homeworks/assets/75438030/94342d12-eefb-45d7-8e67-c368c411e13c)

![Screenshot from 2024-01-06 16-55-50](https://github.com/alexnet123/homeworks/assets/75438030/9f34c6d4-c225-40c3-a9cf-ca50e8e41d69)

![Screenshot from 2024-01-06 16-58-34](https://github.com/alexnet123/homeworks/assets/75438030/70d784fe-4209-4c63-a09f-be72f5c92ef3)


### Product Owner

Вашему проекту нужна бизнесовая доработка: нужно поменять JSON ответа на вызов метода GET `/rest/api/get_info`, необходимо создать Issue в котором указать:

1. Какой метод необходимо исправить.
2. Текст с `{ "message": "Already started" }` на `{ "message": "Running"}`.
3. Issue поставить label: feature.

![Screenshot from 2024-01-06 17-17-28](https://github.com/alexnet123/homeworks/assets/75438030/facdfa9d-c139-4b5d-917d-c8fae370fcd5)


### Developer

Пришёл новый Issue на доработку, вам нужно:

1. Создать отдельную ветку, связанную с этим Issue.
2. Внести изменения по тексту из задания.
3. Подготовить Merge Request, влить необходимые изменения в `master`, проверить, что сборка прошла успешно.

```
root@debian:/home/alex/test# git clone http://51.250.6.58/root/my-pro.git
Cloning into 'my-pro'...
remote: Enumerating objects: 18, done.
remote: Counting objects: 100% (18/18), done.
remote: Compressing objects: 100% (16/16), done.
remote: Total 18 (delta 4), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (18/18), 4.80 KiB | 702.00 KiB/s, done.
Resolving deltas: 100% (4/4), done.
root@debian:/home/alex/test# cd my-pro
root@debian:/home/alex/test/my-pro# git checkout -b feature/change-get-info-response
Switched to a new branch 'feature/change-get-info-response'
root@debian:/home/alex/test/my-pro# cat python-api.py 
from flask import Flask, request
from flask_restful import Resource, Api
from json import dumps
from flask_jsonpify import jsonify

app = Flask(__name__)
api = Api(app)

class Info(Resource):
    def get(self):
        return {'version': 3, 'method': 'GET', 'message': 'Already started'}

api.add_resource(Info, '/get_info')

if __name__ == '__main__':
     app.run(host='0.0.0.0', port='5290')
root@debian:/home/alex/test/my-pro# nano python-api.py 
root@debian:/home/alex/test/my-pro# cat python-api.py 
from flask import Flask, request
from flask_restful import Resource, Api
from json import dumps
from flask_jsonpify import jsonify

app = Flask(__name__)
api = Api(app)

class Info(Resource):
    def get(self):
        return {'version': 3, 'method': 'GET', 'message': 'Running'}

api.add_resource(Info, '/get_info')

if __name__ == '__main__':
     app.run(host='0.0.0.0', port='5290')
root@debian:/home/alex/test/my-pro# git status
On branch feature/change-get-info-response
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   python-api.py

no changes added to commit (use "git add" and/or "git commit -a")
root@debian:/home/alex/test/my-pro# git add *
root@debian:/home/alex/test/my-pro# git status
On branch feature/change-get-info-response
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	modified:   python-api.py

root@debian:/home/alex/test/my-pro# git commit -m "Changed GET /rest/api/get_info"
[feature/change-get-info-response ce1cd9b] Changed GET /rest/api/get_info
 1 file changed, 1 insertion(+), 1 deletion(-)
root@debian:/home/alex/test/my-pro# git push origin feature/change-get-info-response
Username for 'http://51.250.6.58': root
Password for 'http://root@51.250.6.58': 
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 306 bytes | 306.00 KiB/s, done.
Total 3 (delta 2), reused 0 (delta 0), pack-reused 0
remote: 
remote: To create a merge request for feature/change-get-info-response, visit:
remote:   http://51.250.6.58/root/my-pro/-/merge_requests/new?merge_request%5Bsource_branch%5D=feature%2Fchange-get-info-response
remote: 
To http://51.250.6.58/root/my-pro.git
 * [new branch]      feature/change-get-info-response -> feature/change-get-info-response
root@debian:/home/alex/test/my-pro# 


```

![Screenshot from 2024-01-06 17-27-24](https://github.com/alexnet123/homeworks/assets/75438030/4ffb85a5-c8c0-4bf3-b6df-c73fdfc2ef12)

![Screenshot from 2024-01-06 17-36-53](https://github.com/alexnet123/homeworks/assets/75438030/323db163-3637-4f44-93bd-37da179d93f2)


### Tester

Разработчики выполнили новый Issue, необходимо проверить валидность изменений:

1. Поднять докер-контейнер с образом `python-api:latest` и проверить возврат метода на корректность.
2. Закрыть Issue с комментарием об успешности прохождения, указав желаемый результат и фактически достигнутый.

## Итог

В качестве ответа пришлите подробные скриншоты по каждому пункту задания:

- файл gitlab-ci.yml;
- Dockerfile; 
- лог успешного выполнения пайплайна;
- решённый Issue.

### Важно 
После выполнения задания выключите и удалите все задействованные ресурсы в Yandex Cloud.

