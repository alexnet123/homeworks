# Домашнее задание к занятию «Инструменты Git» Вахрамеев А.В.


## Задание

В клонированном репозитории:

1. Найдите полный хеш и комментарий коммита, хеш которого начинается на `aefea`.

```
root@PC-DB:/home/alex/test/terraform# git log --oneline | grep aefea
aefead220 Update CHANGELOG.md
root@PC-DB:/home/alex/test/terraform# git show aefead220
commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
Date:   Thu Jun 18 10:29:58 2020 -0400

    Update CHANGELOG.md

diff --git a/CHANGELOG.md b/CHANGELOG.md
index 86d70e3e0..588d807b1 100644
--- a/CHANGELOG.md
+++ b/CHANGELOG.md
@@ -27,6 +27,7 @@ BUG FIXES:
 * backend/s3: Prefer AWS shared configuration over EC2 metadata credentials by default ([#25134](https://github.com/hashicorp/terraform/issues/25134))
 * backend/s3: Prefer ECS credentials over EC2 metadata credentials by default ([#25134](https://github.com/hashicorp/terraform/issues/25134))
 * backend/s3: Remove hardcoded AWS Provider messaging ([#25134](https://github.com/hashicorp/terraform/issues/25134))
+* command: Fix bug with global `-v`/`-version`/`--version` flags introduced in 0.13.0beta2 [GH-25277]
 * command/0.13upgrade: Fix `0.13upgrade` usage help text to include options ([#25127](https://github.com/hashicorp/terraform/issues/25127))
 * command/0.13upgrade: Do not add source for builtin provider ([#25215](https://github.com/hashicorp/terraform/issues/25215))
 * command/apply: Fix bug which caused Terraform to silently exit on Windows when using absolute plan path ([#25233](https://github.com/hashicorp/terraform/issues/25233))

```

2. Ответьте на вопросы.

* Какому тегу соответствует коммит `85024d3`?

```
root@PC-DB:/home/alex/test/terraform# git tag --contains 85024d3
v0.12.23
v0.12.24
v0.12.25
v0.12.26
v0.12.27
v0.12.28
v0.12.29
v0.12.30
v0.12.31

```

* Сколько родителей у коммита `b8d720`? Напишите их хеши.

```
root@PC-DB:/home/alex/test/terraform# git log --oneline | grep b8d720
b8d720f83 Merge pull request #23916 from hashicorp/cgriggs01-stable
root@PC-DB:/home/alex/test/terraform# git show --pretty=%P b8d720f83
56cd7859e05c36c06b56d013b55a252d0bb7e158 9ea88f22fc6269854151c571162c5bcf958bee2b

```

* Перечислите хеши и комментарии всех коммитов, которые были сделаны между тегами  v0.12.23 и v0.12.24.
```
root@PC-DB:/home/alex/test/terraform# git log --pretty=oneline v0.12.23..v0.12.24
33ff1c03bb960b332be3af2e333462dde88b279e (tag: v0.12.24) v0.12.24
b14b74c4939dcab573326f4e3ee2a62e23e12f89 [Website] vmc provider links
3f235065b9347a758efadc92295b540ee0a5e26e Update CHANGELOG.md
6ae64e247b332925b872447e9ce869657281c2bf registry: Fix panic when server is unreachable
5c619ca1baf2e21a155fcdb4c264cc9e24a2a353 website: Remove links to the getting started guide's old location
06275647e2b53d97d4f0a19a0fec11f6d69820b5 Update CHANGELOG.md
d5f9411f5108260320064349b757f55c09bc4b80 command: Fix bug when using terraform login on Windows
4b6d06cc5dcb78af637bbb19c198faff37a066ed Update CHANGELOG.md
dd01a35078f040ca984cdd349f18d0b67e486c35 Update CHANGELOG.md
225466bc3e5f35baa5d07197bbc079345b77525e Cleanup after v0.12.23 release

```

* Найдите коммит, в котором была создана функция `func providerSource`, её определение в коде выглядит так: `func providerSource(...)` (вместо троеточия перечислены аргументы).

```
root@PC-DB:/home/alex/test/terraform# git log -S "func providerSource(" -p --reverse
commit 8c928e83589d90a031f811fae52a81be7153e82f

func providerSource(services *disco.Disco) getproviders.Source {
       // We're not yet using the CLI config here because we've not implemented
       // yet the new configuration constructs to customize provider search

```

* Найдите все коммиты, в которых была изменена функция `globalPluginDirs`.

```
root@PC-DB:/home/alex/test/terraform# git log -S globalPluginDirs --oneline
65c4ba7363 Remove terraform binary
125eb51dc4 Remove accidentally-committed binary
22c121df86 Bump compatibility version to 1.3.0 for terraform core release (#30988)
7c7e5d8f0a Don't show data while input if sensitive
35a058fb3d main: configure credentials from the CLI config file
c0b1761096 prevent log output during init
8364383c35 Push plugin discovery down into command package

```

* Кто автор функции `synchronizedWriters`? 

```
root@PC-DB:/home/alex/test/terraform# git log -S synchronizedWriters | grep -P "Author|Date"

Author: James Bardin <j.bardin@gmail.com>
Date:   Mon Nov 30 18:02:04 2020 -0500
Author: James Bardin <j.bardin@gmail.com>
Date:   Wed Oct 21 13:06:23 2020 -0400
Author: Martin Atkins <mart@degeneration.co.uk>
Date:   Wed May 3 16:25:41 2017 -0700

```

*В качестве решения ответьте на вопросы и опишите, как были получены эти ответы.*

---
