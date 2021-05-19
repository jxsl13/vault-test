path "/secrets/*" {
        capabilities = ["list", "read" ]
    }

path "/identity/*" {
    capabilities = ["list"]
}

path "/sys/policies/*" {
    capabilities = ["list"]
}
