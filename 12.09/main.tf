terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = "y0_AgAAAABkbnEbAATuwQAAAADRe319HyCOnGH2Q2SiGV_TEQrlLBgz1RI"      
  cloud_id  = "b1gbalrr4suqf4hapk6f"
  folder_id = "b1gq0mj5rh4up9offieh"
  zone      = "ru-central1-a"

  # token     = "<OAuth или статический ключ сервисного аккаунта>"
  # cloud_id  = "<идентификатор облака>"
  # folder_id = "<идентификатор каталога>"
  # zone      = "<зона доступности>"
}

resource "yandex_mdb_postgresql_cluster" "my-pgsql-cl" {
  name                = "my-pgsql-cl" #"<имя кластера>"
  environment         = "PRODUCTION"  #"<окружение, PRESTABLE или PRODUCTION>"
  network_id          = yandex_vpc_network.default_new.id # "<идентификатор сети>"
  #security_group_ids  = [ "<список групп безопасности>" ]
  #deletion_protection = <защита от удаления кластера: true или false>

  config {
    version = "14" #"<версия PostgreSQL: 11, 11-1c, 12, 12-1c, 13, 13-1c, 14, 14-1c или 15>"
    resources {
      resource_preset_id = "s2.micro" #"<класс хоста>"
      disk_type_id       = "network-ssd" #"<тип диска>"
      disk_size          = 10 #<размер хранилища, ГБ>
    }
    # pooler_config {
    #   pool_discard = <параметр Odyssey pool_discard: true или false>
    #   pooling_mode = "<режим работы: SESSION, TRANSACTION или STATEMENT>"
    # }
    
  }

  host {
    zone      = "ru-central1-a" #"<зона доступности>"
    name      = "mypg-host-a" #"<имя хоста>"
    subnet_id = yandex_vpc_subnet.default-new-ru-central1-a.id #"<идентификатор подсети>"
  }
  host {
    zone      = "ru-central1-b" #"<зона доступности>"
    name      = "mypg-host-b" #"<имя хоста>"
    subnet_id = yandex_vpc_subnet.default-new-ru-central1-b.id #"<идентификатор подсети>"
  }
  host {
    zone      = "ru-central1-c" #"<зона доступности>"
    name      = "mypg-host-c" #"<имя хоста>"
    subnet_id = yandex_vpc_subnet.default-new-ru-central1-c.id #"<идентификатор подсети>"
  }
}

resource "yandex_mdb_postgresql_database" "db1" {
  cluster_id = yandex_mdb_postgresql_cluster.my-pgsql-cl.id #"<идентификатор кластера>"
  name       = "db1" #"<имя базы данных>"
  owner      = "user" #"<имя владельца базы данных>"
  depends_on = [
    yandex_mdb_postgresql_user.user #<имя пользователя>
  ]
}

resource "yandex_mdb_postgresql_user" "user" {
  cluster_id = yandex_mdb_postgresql_cluster.my-pgsql-cl.id #"<идентификатор кластера>"
  name       = "user" #"<имя пользователя>"
  password   = "qwertyX14" #"<пароль пользователя>"
}

resource "yandex_vpc_network" "default_new" { 
  name = "default_new" 
}

resource "yandex_vpc_subnet" "default-new-ru-central1-c" {
  name           = "default-new-ru-central1-c" #"<имя подсети>"
  zone           = "ru-central1-c" #"<зона доступности>"
  network_id     = yandex_vpc_network.default_new.id #"<идентификатор сети>"
  v4_cidr_blocks = ["10.131.0.0/24"]
}

resource "yandex_vpc_subnet" "default-new-ru-central1-a" {
  name           = "default-new-ru-central1-a" #"<имя подсети>"
  zone           = "ru-central1-a" #"<зона доступности>"
  network_id     = yandex_vpc_network.default_new.id #"<идентификатор сети>"
  v4_cidr_blocks = ["10.132.0.0/24"]
}

resource "yandex_vpc_subnet" "default-new-ru-central1-b" {
  name           = "default-new-ru-central1-b" #"<имя подсети>"
  zone           = "ru-central1-b" #"<зона доступности>"
  network_id     = yandex_vpc_network.default_new.id #"<идентификатор сети>"
  v4_cidr_blocks = ["10.133.0.0/24"]
}
