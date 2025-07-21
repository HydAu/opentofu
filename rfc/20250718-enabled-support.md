# Conditional field for enabling resources and modules

## Current status

Issue: https://github.com/opentofu/opentofu/issues/1306

Right now, OpenTofu supports conditional enable/disable of resources by using a workaround with `count`.
This approach brings a few problems, like adding indexes to resources that would be a single instance, making it harder to manage using these indexes.

This RFC proposes a new way to do a cleaner and semantic way by using a new field on the `lifecycle` block called `enabled`:

```
resource "aws_instance" "example" {
  # ...

  lifecycle {
    enabled = var.enable_server
  }
}
```

## Proposed Solution

1. Add a new field on the `lifecycle` block called `enabled`;
1. Raise errors if a resource is used while being disabled;
1. Support for conditional enabling for:
  1. Resources
  1. Modules

## Errors when resource is not enabled 

If a resource is disabled, it shouldn't be possible to access the attributes since the resource
is not on the graph. We prefer to loudly tell the user they're trying to access something that is not
available. In order to have a good user experience while they want to enable/disable stuff, we
offer a way to silently fail while trying to access that, by using the `try` function.

## Open questions

1. Can we use unknown values as expressions on the `enabled` field?
  1. My initial answer would be no.
1. How to migrate from existing count managed resources to use `enabled`?
  1. Need to provide a good way that is not too brittle
1. What should we do if a previously enabled resource is disabled?
  1. Should we destroy or ignore the previous state?
1. Should we support `enabled` together with `for_each` or `count`? 
  1. My initial answer would be no, since the three of them acts like expanders.
1. Since we're using `lifecycle` for having the resource enabled, what should we use on `modules`?
  1. Should we add `lifecycle` to `modules`? https://opentofu.org/docs/language/modules/syntax/#meta-arguments On this page we're saying `lifecycle` is reserved for future usage.
