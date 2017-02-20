import marshal, tables
import client_itsyouonline

import Contract
import DnsAddress
import GetOrganizationUsersResponseBody
import JoinOrganizationInvitation
import LocalizedInfoText
import Member
import Membership
import Organization
import OrganizationAPIKey
import OrganizationTreeItem
import RegistryEntry
import RequiredScope
import organizationsglobalidapikeyslabelPutReqBody
import organizationsglobalidlogoPutReqBody
import organizationsglobalidorgmembersPostReqBody
import organizationsglobalidorgmembersPutReqBody
import organizationsglobalidorgmembersincludesuborgsPostReqBody
import organizationsglobalidorgmembersincludesuborgsPostRespBody
import organizationsglobalidorgmembersinvitePostReqBody
import organizationsglobalidorgownersPostReqBody
import organizationsglobalidorgownersinvitePostReqBody


type
  Organizations_service* = object
    client*: Client
    name*: string

proc OrganizationsSrv*(c : Client) : Organizations_service  =
  return Organizations_service(client:c, name:c.baseURI)


proc CreateNewOrganization*(srv: Organizations_service, reqBody: Organization, queryParams: Table[string, string] = initTable[string, string]()) : Organization =
  # Create a new organization. 1 user should be in the owners list. Validation is performed to check if the securityScheme allows management on this user.
  # It calls POST /organizations endpoint.

  let resp = srv.client.request("/organizations", "POST", $$reqBody, queryParams=queryParams)
  return to[Organization](resp.body)

proc GetOrganization*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : Organization =
  # Get organization info
  # It calls GET /organizations/{globalid} endpoint.

  let resp = srv.client.request("/organizations/"&globalid, "GET", queryParams=queryParams)
  return to[Organization](resp.body)

proc CreateNewSubOrganization*(srv: Organizations_service, reqBody: Organization, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : Organization =
  # Create a new suborganization.
  # It calls POST /organizations/{globalid} endpoint.

  let resp = srv.client.request("/organizations/"&globalid, "POST", $$reqBody, queryParams=queryParams)
  return to[Organization](resp.body)

proc UpdateOrganization*(srv: Organizations_service, reqBody: Organization, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : Organization =
  # Update organization info
  # It calls PUT /organizations/{globalid} endpoint.

  let resp = srv.client.request("/organizations/"&globalid, "PUT", $$reqBody, queryParams=queryParams)
  return to[Organization](resp.body)

proc DeleteOrganization*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Deletes an organization and all data linked to it (join-organization-invitations, oauth_access_tokens, oauth_clients, logo)
  # It calls DELETE /organizations/{globalid} endpoint.

  let resp = srv.client.request("/organizations/"&globalid, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetOrganizationUsers*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : GetOrganizationUsersResponseBody =
  # Get all users from this organization, not including suborganizations.
  # It calls GET /organizations/{globalid}/users endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/users", "GET", queryParams=queryParams)
  return to[GetOrganizationUsersResponseBody](resp.body)

proc AddOrganizationOwner*(srv: Organizations_service, reqBody: Member, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : Member =
  # Invite someone to become owner of an organization.
  # It calls POST /organizations/{globalid}/owners endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/owners", "POST", $$reqBody, queryParams=queryParams)
  return to[Member](resp.body)

proc RemoveOrganizationOwner*(srv: Organizations_service, username: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Remove an owner from organization
  # It calls DELETE /organizations/{globalid}/owners/{username} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/owners/"&username, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetOrganizationContracts*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Get the contracts where the organization is 1 of the parties. Order descending by date.
  # It calls GET /organizations/{globalid}/contracts endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/contracts", "GET", queryParams=queryParams)
  return to[string](resp.body)

proc CreateOrganizationContracty*(srv: Organizations_service, reqBody: Contract, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : Contract =
  # Create a new contract.
  # It calls POST /organizations/{globalid}/contracts endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/contracts", "POST", $$reqBody, queryParams=queryParams)
  return to[Contract](resp.body)

proc ListOrganizationRegistry*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[RegistryEntry] =
  # Lists the RegistryEntries in an organization's registry.
  # It calls GET /organizations/{globalid}/registry endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/registry", "GET", queryParams=queryParams)
  return to[seq[RegistryEntry]](resp.body)

proc AddOrganizationRegistryEntry*(srv: Organizations_service, reqBody: RegistryEntry, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : RegistryEntry =
  # Adds a RegistryEntry to the organization's registry, if the key is already used, it is overwritten.
  # It calls POST /organizations/{globalid}/registry endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/registry", "POST", $$reqBody, queryParams=queryParams)
  return to[RegistryEntry](resp.body)

proc AddRequiredScope*(srv: Organizations_service, reqBody: RequiredScope, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Adds a required scope
  # It calls POST /organizations/{globalid}/requiredscopes endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/requiredscopes", "POST", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc UpdateRequiredScope*(srv: Organizations_service, requiredscope: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Updates a required scope
  # It calls PUT /organizations/{globalid}/requiredscopes/{requiredscope} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/requiredscopes/"&requiredscope, "PUT", queryParams=queryParams)
  return to[string](resp.body)

proc DeleteRequiredScope*(srv: Organizations_service, requiredscope: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Deletes a required scope
  # It calls DELETE /organizations/{globalid}/requiredscopes/{requiredscope} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/requiredscopes/"&requiredscope, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc SetDescription*(srv: Organizations_service, reqBody: LocalizedInfoText, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : LocalizedInfoText =
  # Set the description for this organization for a given language key
  # It calls POST /organizations/{globalid}/description endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/description", "POST", $$reqBody, queryParams=queryParams)
  return to[LocalizedInfoText](resp.body)

proc UpdateDescription*(srv: Organizations_service, reqBody: LocalizedInfoText, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : LocalizedInfoText =
  # Update the description for this organization for a given language key
  # It calls PUT /organizations/{globalid}/description endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/description", "PUT", $$reqBody, queryParams=queryParams)
  return to[LocalizedInfoText](resp.body)

proc GetDescription*(srv: Organizations_service, langkey: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : LocalizedInfoText =
  # Get the description for an organization for this langkey
  # It calls GET /organizations/{globalid}/description/{langkey} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/description/"&langkey, "GET", queryParams=queryParams)
  return to[LocalizedInfoText](resp.body)

proc DeleteDescription*(srv: Organizations_service, langkey: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Delete the description for this organization for a given language key
  # It calls DELETE /organizations/{globalid}/description/{langkey} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/description/"&langkey, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetDescriptionWithFallback*(srv: Organizations_service, langkey: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : LocalizedInfoText =
  # Get the description for an organization for this langkey, try to use the English is there is no description for this langkey
  # It calls GET /organizations/{globalid}/description/{langkey}/withfallback endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/description/"&langkey&"/withfallback", "GET", queryParams=queryParams)
  return to[LocalizedInfoText](resp.body)

proc Get2faValidityTime*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : int =
  # Get the 2FA validity time for the organization, in seconds
  # It calls GET /organizations/{globalid}/2fa/validity endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/2fa/validity", "GET", queryParams=queryParams)
  return to[int](resp.body)

proc Set2faValidityTime*(srv: Organizations_service, reqBody: int, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Update the 2FA validity time for the organization
  # It calls POST /organizations/{globalid}/2fa/validity endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/2fa/validity", "POST", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc SetOrgMember*(srv: Organizations_service, reqBody: organizationsglobalidorgmembersPostReqBody, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Add another organization as a member of this one
  # It calls POST /organizations/{globalid}/orgmembers endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/orgmembers", "POST", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc UpdateOrganizationOrgMemberShip*(srv: Organizations_service, reqBody: organizationsglobalidorgmembersPutReqBody, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : Organization =
  # Update the membership status of an organization
  # It calls PUT /organizations/{globalid}/orgmembers endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/orgmembers", "PUT", $$reqBody, queryParams=queryParams)
  return to[Organization](resp.body)

proc AddOrganizationOrgMember*(srv: Organizations_service, reqBody: organizationsglobalidorgmembersinvitePostReqBody, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : JoinOrganizationInvitation =
  # Invite another organization as a member of this one
  # It calls POST /organizations/{globalid}/orgmembers/invite endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/orgmembers/invite", "POST", $$reqBody, queryParams=queryParams)
  return to[JoinOrganizationInvitation](resp.body)

proc DeleteOrgMember*(srv: Organizations_service, globalid2: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Remove an organization as a member
  # It calls DELETE /organizations/{globalid}/orgmembers/{globalid2} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/orgmembers/"&globalid2, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc AddIncludeSubOrgsOf*(srv: Organizations_service, reqBody: organizationsglobalidorgmembersincludesuborgsPostReqBody, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : organizationsglobalidorgmembersincludesuborgsPostRespBody =
  # Add an orgmember or orgowner organization to the includesuborgsof list
  # It calls POST /organizations/{globalid}/orgmembers/includesuborgs endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/orgmembers/includesuborgs", "POST", $$reqBody, queryParams=queryParams)
  return to[organizationsglobalidorgmembersincludesuborgsPostRespBody](resp.body)

proc RemoveIncludeSubOrgsOf*(srv: Organizations_service, orgmember: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Remove an orgmember or orgowner organization to the includesuborgsof list
  # It calls DELETE /organizations/{globalid}/orgmembers/includesuborgs/{orgmember} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/orgmembers/includesuborgs/"&orgmember, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc AcceptOrganizationInvite*(srv: Organizations_service, reqBody: JoinOrganizationInvitation, invitingorg: string, role: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : JoinOrganizationInvitation =
  # Accept the invite for one of your organizations
  # It calls POST /organizations/{globalid}/organizations/{invitingorg}/roles/{role} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/organizations/"&invitingorg&"/roles/"&role, "POST", $$reqBody, queryParams=queryParams)
  return to[JoinOrganizationInvitation](resp.body)

proc RejectOrganizationInvite*(srv: Organizations_service, invitingorg: string, role: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Reject the invite for one of your organizations
  # It calls DELETE /organizations/{globalid}/organizations/{invitingorg}/roles/{role} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/organizations/"&invitingorg&"/roles/"&role, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc AddOrganizationMember*(srv: Organizations_service, reqBody: Member, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : Member =
  # Invite someone to become member of an organization.
  # It calls POST /organizations/{globalid}/members endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/members", "POST", $$reqBody, queryParams=queryParams)
  return to[Member](resp.body)

proc UpdateOrganizationMemberShip*(srv: Organizations_service, reqBody: Membership, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : Organization =
  # Update an organization membership
  # It calls PUT /organizations/{globalid}/members endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/members", "PUT", $$reqBody, queryParams=queryParams)
  return to[Organization](resp.body)

proc RemoveOrganizationMember*(srv: Organizations_service, username: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Remove a member from an organization.
  # It calls DELETE /organizations/{globalid}/members/{username} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/members/"&username, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetOrganizationRegistryEntry*(srv: Organizations_service, key: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : RegistryEntry =
  # Get a RegistryEntry from the organization's registry.
  # It calls GET /organizations/{globalid}/registry/{key} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/registry/"&key, "GET", queryParams=queryParams)
  return to[RegistryEntry](resp.body)

proc DeleteOrganizationRegistryEntry*(srv: Organizations_service, key: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Removes a RegistryEntry from the organization's registry
  # It calls DELETE /organizations/{globalid}/registry/{key} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/registry/"&key, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc CreateOrganizationDns*(srv: Organizations_service, reqBody: DnsAddress, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : DnsAddress =
  # Creates a new DNS name associated with an organization
  # It calls POST /organizations/{globalid}/dns endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/dns", "POST", $$reqBody, queryParams=queryParams)
  return to[DnsAddress](resp.body)

proc UpdateOrganizationDns*(srv: Organizations_service, reqBody: DnsAddress, dnsname: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Updates an existing DNS name associated with an organization
  # It calls PUT /organizations/{globalid}/dns/{dnsname} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/dns/"&dnsname, "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteOrganizationDns*(srv: Organizations_service, dnsname: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Removes a DNS name associated with an organization
  # It calls DELETE /organizations/{globalid}/dns/{dnsname} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/dns/"&dnsname, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetOrganizationLogo*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Get the Logo from an organization
  # It calls GET /organizations/{globalid}/logo endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/logo", "GET", queryParams=queryParams)
  return to[string](resp.body)

proc SetOrganizationLogo*(srv: Organizations_service, reqBody: organizationsglobalidlogoPutReqBody, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Set the organization Logo for the organization
  # It calls PUT /organizations/{globalid}/logo endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/logo", "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteOrganizationLogo*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Removes the Logo from an organization
  # It calls DELETE /organizations/{globalid}/logo endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/logo", "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc SetOrgOwner*(srv: Organizations_service, reqBody: organizationsglobalidorgownersPostReqBody, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Add another organization as an owner of this one
  # It calls POST /organizations/{globalid}/orgowners endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/orgowners", "POST", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteOrgOwner*(srv: Organizations_service, globalid2: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Remove an organization as an owner
  # It calls DELETE /organizations/{globalid}/orgowners/{globalid2} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/orgowners/"&globalid2, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc AddOrganizationOrgOwner*(srv: Organizations_service, reqBody: organizationsglobalidorgownersinvitePostReqBody, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : JoinOrganizationInvitation =
  # Invite another organization as an owner of this one
  # It calls POST /organizations/{globalid}/orgowners/invite endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/orgowners/invite", "POST", $$reqBody, queryParams=queryParams)
  return to[JoinOrganizationInvitation](resp.body)

proc GetInvitations*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[JoinOrganizationInvitation] =
  # Get the list of pending invitations for users to join this organization.
  # It calls GET /organizations/{globalid}/invitations endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/invitations", "GET", queryParams=queryParams)
  return to[seq[JoinOrganizationInvitation]](resp.body)

proc RemovePendingOrganizationInvitation*(srv: Organizations_service, username: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Cancel a pending invitation.
  # It calls DELETE /organizations/{globalid}/invitations/{username} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/invitations/"&username, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetOrganizationAPIKeyLabels*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[string] =
  # Get the list of active api keys.
  # It calls GET /organizations/{globalid}/apikeys endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/apikeys", "GET", queryParams=queryParams)
  return to[seq[string]](resp.body)

proc CreateNewOrganizationAPIKey*(srv: Organizations_service, reqBody: OrganizationAPIKey, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : OrganizationAPIKey =
  # Create a new API Key, a secret itself should not be provided, it will be generated serverside.
  # It calls POST /organizations/{globalid}/apikeys endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/apikeys", "POST", $$reqBody, queryParams=queryParams)
  return to[OrganizationAPIKey](resp.body)

proc GetOrganizationAPIKey*(srv: Organizations_service, label: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : OrganizationAPIKey =
  # Get an api key from an organization
  # It calls GET /organizations/{globalid}/apikeys/{label} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/apikeys/"&label, "GET", queryParams=queryParams)
  return to[OrganizationAPIKey](resp.body)

proc UpdateOrganizationAPIKey*(srv: Organizations_service, reqBody: organizationsglobalidapikeyslabelPutReqBody, label: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Updates the label or other properties of a key.
  # It calls PUT /organizations/{globalid}/apikeys/{label} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/apikeys/"&label, "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteOrganizationAPIKey*(srv: Organizations_service, label: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Removes an API key
  # It calls DELETE /organizations/{globalid}/apikeys/{label} endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/apikeys/"&label, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetOrganizationTree*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[OrganizationTreeItem] =
  # Tree structure of all suborganizations
  # It calls GET /organizations/{globalid}/tree endpoint.

  let resp = srv.client.request("/organizations/"&globalid&"/tree", "GET", queryParams=queryParams)
  return to[seq[OrganizationTreeItem]](resp.body)

