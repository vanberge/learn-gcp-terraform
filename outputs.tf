output "vm" {
    value = module.instances.vm_name
}
output "ip" {
    value = module.instances.vm_ip
}
output "vpc"{
    value = module.network.vpc_network
}