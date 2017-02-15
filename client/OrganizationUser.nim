
type
  OrganizationUser* = object
    missingscopes*: seq[string]
    role*: string
    username*: string
