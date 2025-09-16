[webservers]
%{ for web in web_vms ~}
${web.name} ansible_host=${web.public_ip} fqdn=${web.fqdn}
%{ endfor ~}

[databases]
%{ for db in db_vms ~}
${db.name} ansible_host=${db.public_ip} fqdn=${db.fqdn}
%{ endfor ~}

[storage]
%{ for storage in storage_vms ~}
${storage.name} ansible_host=${storage.public_ip} fqdn=${storage.fqdn}
%{ endfor ~}
