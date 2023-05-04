output "sample" {
    value = "print values - {$var.sample}"
}

output "sample1" {
    value = "list values: ${var.sample_list[1]} ${var.sample_list[2]}"
}

output "sample2" {
    value = "map value: ${var.sample_map.number1} ${var.sample_map.name1} "
}