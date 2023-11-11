output "vm_external_ip_address" {
  description = "Map of VM instance names to their external IPs"
  value = {
    vm_db_ip = yandex_compute_instance.vm_db.network_interface[0].nat_ip_address,
    vm_web_ip = yandex_compute_instance.vm_web.network_interface[0].nat_ip_address
  }
}



# Напишите, какой командой можно отобразить второй элемент списка test_list.
output "test_list" {
  value = local.test_list[1]
}

# Найдите длину списка test_list с помощью функции length(<имя переменной>).
output "len" {
  value = length(local.test_list)
}

# Напишите, какой командой можно отобразить значение ключа admin из map test_map.
output "name" {
  value = local.test_map["admin"]
}

# Напишите interpolation-выражение, результатом которого будет: "John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks", используйте данные из переменных test_list, test_map, servers и функцию length() для подстановки значений.
output "name2" {
  value = "${local.test_map.admin} is admin for ${local.test_list[2]} server based on OS ${local.servers[local.test_list[2]].image} with ${local.servers[local.test_list[2]].cpu} vcpu, ${local.servers[local.test_list[2]].ram} ram and ${length(local.servers[local.test_list[2]].disks)} virtual disks"

}