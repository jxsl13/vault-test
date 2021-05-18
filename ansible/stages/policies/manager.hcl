path "/secret/*" {
        capabilities = ["create", "read", "update", "delete", "list"]
    }

path "/identity/*" {
    capabilities = ["list"]
}

path "/sys/policies/*" {
    capabilities = ["list", "read", "update", "create"]
}