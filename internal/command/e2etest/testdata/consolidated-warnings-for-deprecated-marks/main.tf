module "call" {
  source = "./mod1"
  input  = "test"
  input2 = "test2"
}

module "second_call" {
  source = "./mod1"
  input  = "test"
  input2 = "test2"
}

module "mod2_call" {
  source = "./mod2"
  # These two inputs are not going to consolidate since they have different deprecated messages
  input  = "test"
}

locals {
  i1 = module.call.modout1
  i2 = module.call.modout2
  i3 = module.second_call.modout1
  i4 = module.second_call.modout2
  i5 = module.mod2_call.modout1
}
