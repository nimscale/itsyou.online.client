
import OrganizationUser
type
  GetOrganizationUsersResponseBody* = object
    haseditpermissions*: bool
    users*: seq[OrganizationUser]
