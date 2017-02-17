
import ContractSigningRequest
import JoinOrganizationInvitation
import MissingScopes
type
  usersusernamenotificationsGetRespBody* = object
    approvals*: seq[JoinOrganizationInvitation]
    contractRequests*: seq[ContractSigningRequest]
    invitations*: seq[JoinOrganizationInvitation]
    missingscopes*: seq[MissingScopes]
