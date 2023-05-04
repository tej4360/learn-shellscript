variable "sample" {
    default = "hello world"
}

variable "sample_list" {
    default = {
    100,
    "hello",
    true,
    20.6
    }
}

variable "sample_map" {
    default = {
        number1 = 12
        name1 = "abc"
        boolean = "true"
    }
}