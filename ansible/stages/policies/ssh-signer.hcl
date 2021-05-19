path "/secrets/*" {
        capabilities = ["list", "read" ]
    }

path "/identity/*" {
    capabilities = ["list"]
}

path "/sys/policies/*" {
    capabilities = ["list"]
}

path "/ssh/*" {
    capabilities = ["list", "read"]
}

# a policy name containing the ssh or SSH is automatically translated into a ssh role
path "/ssh/sign/ssh-signer" {
    capabilities = ["list", "read", "create", "update"]
}