resource "local_file" "ansible_inventory" {
  content  = templatefile("inventory.tpl", {
    webservers = yandex_compute_instance.vm,
    databases  = yandex_compute_instance.vm_a,
    storage    = [yandex_compute_instance.storage_vm],
  })

  filename = "hosts"
}