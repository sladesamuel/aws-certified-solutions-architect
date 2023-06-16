# Simple Network

Provisions a simple network with 2x public Subnets and 4x private Subnets (2 for application servers and 2 for database instances). Also sets up the applications servers within an Auto Scaling Group and a multi-AZ Aurora database.

**Architecture**

![architecture](./images/architecture.png)

## Running the example

> Note that all below commands require AWS credentials. You can either [configure your AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) instance using access/secret keys or profiles, or you can make use of the [AWS Vault](https://github.com/99designs/aws-vault).

Before running, make sure the local Terraform state is initialized and all modules installed.

```shell
$ make init
```

Then to provision the changes, run the following:

```shell
$ make apply
```

It is recommended that you destroy the resources once you are finished, so that you don't incur undesired costs. To do this, run the following:

```shell
$ make destroy
```
