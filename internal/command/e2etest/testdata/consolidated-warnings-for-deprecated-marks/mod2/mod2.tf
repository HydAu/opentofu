variable "input" {
  type       = string
  default    = "val"
  deprecated = "mod2 is another deprecation"
}

output "modout1" {
  value      = var.input
  deprecated = "output deprecated from another module"
}
