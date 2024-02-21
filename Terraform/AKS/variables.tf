variable "env" {
  type = object({
    location        = string
    subscription_id = string
  })
}

variable "vnet" {
  type = object({
    address_spaces = list(string)
    subnet_list    = map(any)
  })
}



