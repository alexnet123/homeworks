
[databases]
%{ for instance in webservers ~}
${instance.name} ansible_host=${element(instance.network_interface, 0).nat_ip_address}
%{ endfor ~}

[webservers]
%{ for instance in databases ~}
${instance.name} ansible_host=${element(instance.network_interface, 0).nat_ip_address}
%{ endfor ~}

[storage]
%{ for instance in storage ~}
${instance.name} ansible_host=${element(instance.network_interface, 0).nat_ip_address}
%{ endfor ~}