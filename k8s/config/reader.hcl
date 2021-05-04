

# Read permission on the k/v secrets
path "/secret/*" {
    capabilities = ["list"]
}

path "/secret/webapp/*" {
    capabilities = ["read", "list"]
}

path "/identity/*" {
    capabilities = ["list"]
}

path "/sys/policies/*" {
    capabilities = ["list"]
}