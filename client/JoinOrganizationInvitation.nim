
import EnumJoinOrganizationInvitationMethod
import EnumJoinOrganizationInvitationRole
import EnumJoinOrganizationInvitationStatus
import times
type
  JoinOrganizationInvitation* = object
    created*: Time
    emailaddress*: string
    isorganization*: bool
    method*: EnumJoinOrganizationInvitationMethod
    organization*: string
    phonenumber*: string
    role*: EnumJoinOrganizationInvitationRole
    status*: EnumJoinOrganizationInvitationStatus
    user*: string
