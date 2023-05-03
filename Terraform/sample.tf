variable "sample" {
    default = {
        number = 10
        string = "abc"
    }
}

output "sample" {
        value = "value of map var = ${var.sample.string}"
}