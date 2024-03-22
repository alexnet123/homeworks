resource "local_file" "hosts" {
  content = templatefile("hosts.tmpl",
    {
     yandex_compute_instance_vm_worker     = yandex_compute_instance.vm_worker
     user_vm_worker                        = var.trf_vm_worker_user
     yandex_compute_instance_vm_master     = yandex_compute_instance.vm_master
     user_vm_master                        = var.trf_vm_master_user
    }
  )
  filename = "../ansible/hosts"
}
