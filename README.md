netsh interface ipv4 show excludedportrange protocol=tcp

netsh int ipv4 delete excludedportrange protocol=tcp startport=50000 endport=50059 numberofports=1

netsh int ipv4 delete excludedportrange protocol=tcp startport=50000 numberofports=59
