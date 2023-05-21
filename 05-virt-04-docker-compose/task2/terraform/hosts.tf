resource "local_file" "hosts" {
  content = templatefile("hosts.tmpl",
    {
     yandex_compute_instance_node01     = yandex_compute_instance.node01
     user_node01                        = var.trf_node01_user
     yandex_compute_instance_node02     = yandex_compute_instance.node02
     user_node02                        = var.trf_node02_user
    }
  )
  filename = "../../task3/ansible/hosts"
}