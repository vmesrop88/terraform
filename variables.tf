
variable "instance_count" {
  type    = number
  default = 3
}

variable "instance_name_format" {
  type    = string
  default = "Instance-%d"
}