output "vm_instances" {
  value = concat(
    [
      for instance in yandex_compute_instance.vm : {
        name        = instance.name
        external_ip = element(instance.network_interface, 0).nat_ip_address
        cores       = instance.resources[0].cores
        memory      = instance.resources[0].memory
      }
    ],
    [
      for instance in yandex_compute_instance.vm_a : {
        name        = instance.name
        external_ip = element(instance.network_interface, 0).nat_ip_address
        cores       = instance.resources[0].cores
        memory      = instance.resources[0].memory
      }
    ],
    [
      {
        name        = yandex_compute_instance.storage_vm.name
        external_ip = element(yandex_compute_instance.storage_vm.network_interface, 0).nat_ip_address
        cores       = yandex_compute_instance.storage_vm.resources[0].cores
        memory      = yandex_compute_instance.storage_vm.resources[0].memory
      }
    ]
  )
}