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
  let resp = srv.client.request("/organizations", "POST", $$reqBody, queryParams=queryParams)
  return to[Organization](resp.body)

proc GetOrganization*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : Organization =
  let resp = srv.client.request("/organizations/"&globalid, "GET", queryParams=queryParams)
  return to[Organization](resp.body)

proc CreateNewSubOrganization*(srv: Organizations_service, reqBody: Organization, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : Organization =
  let resp = srv.client.request("/organizations/"&globalid, "POST", $$reqBody, queryParams=queryParams)
  return to[Organization](resp.body)

proc UpdateOrganization*(srv: Organizations_service, reqBody: Organization, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : Organization =
  let resp = srv.client.request("/organizations/"&globalid, "PUT", $$reqBody, queryParams=queryParams)
  return to[Organization](resp.body)

proc DeleteOrganization*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc SetDescription*(srv: Organizations_service, reqBody: LocalizedInfoText, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : LocalizedInfoText =
  let resp = srv.client.request("/organizations/"&globalid&"/description", "POST", $$reqBody, queryParams=queryParams)
  return to[LocalizedInfoText](resp.body)

proc UpdateDescription*(srv: Organizations_service, reqBody: LocalizedInfoText, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : LocalizedInfoText =
  let resp = srv.client.request("/organizations/"&globalid&"/description", "PUT", $$reqBody, queryParams=queryParams)
  return to[LocalizedInfoText](resp.body)

proc GetDescription*(srv: Organizations_service, langkey: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : LocalizedInfoText =
  let resp = srv.client.request("/organizations/"&globalid&"/description/"&langkey, "GET", queryParams=queryParams)
  return to[LocalizedInfoText](resp.body)

proc DeleteDescription*(srv: Organizations_service, langkey: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/description/"&langkey, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetDescriptionWithFallback*(srv: Organizations_service, langkey: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : LocalizedInfoText =
  let resp = srv.client.request("/organizations/"&globalid&"/description/"&langkey&"/withfallback", "GET", queryParams=queryParams)
  return to[LocalizedInfoText](resp.body)

proc GetInvitations*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[JoinOrganizationInvitation] =
  let resp = srv.client.request("/organizations/"&globalid&"/invitations", "GET", queryParams=queryParams)
  return to[seq[JoinOrganizationInvitation]](resp.body)

proc RemovePendingOrganizationInvitation*(srv: Organizations_service, username: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/invitations/"&username, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetOrganizationRegistryEntry*(srv: Organizations_service, key: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : RegistryEntry =
  let resp = srv.client.request("/organizations/"&globalid&"/registry/"&key, "GET", queryParams=queryParams)
  return to[RegistryEntry](resp.body)

proc DeleteOrganizationRegistryEntry*(srv: Organizations_service, key: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/registry/"&key, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetOrganizationTree*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[OrganizationTreeItem] =
  let resp = srv.client.request("/organizations/"&globalid&"/tree", "GET", queryParams=queryParams)
  return to[seq[OrganizationTreeItem]](resp.body)

proc GetOrganizationUsers*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : GetOrganizationUsersResponseBody =
  let resp = srv.client.request("/organizations/"&globalid&"/users", "GET", queryParams=queryParams)
  return to[GetOrganizationUsersResponseBody](resp.body)

proc SetOrgOwner*(srv: Organizations_service, reqBody: organizationsglobalidorgownersPostReqBody, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/orgowners", "POST", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteOrgOwner*(srv: Organizations_service, globalid2: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/orgowners/"&globalid2, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc AddOrganizationOrgOwner*(srv: Organizations_service, reqBody: organizationsglobalidorgownersinvitePostReqBody, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : JoinOrganizationInvitation =
  let resp = srv.client.request("/organizations/"&globalid&"/orgowners/invite", "POST", $$reqBody, queryParams=queryParams)
  return to[JoinOrganizationInvitation](resp.body)

proc AcceptOrganizationInvite*(srv: Organizations_service, reqBody: JoinOrganizationInvitation, invitingorg: string, role: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : JoinOrganizationInvitation =
  let resp = srv.client.request("/organizations/"&globalid&"/organizations/"&invitingorg&"/roles/"&role, "POST", $$reqBody, queryParams=queryParams)
  return to[JoinOrganizationInvitation](resp.body)

proc RejectOrganizationInvite*(srv: Organizations_service, invitingorg: string, role: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/organizations/"&invitingorg&"/roles/"&role, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc CreateOrganizationDns*(srv: Organizations_service, reqBody: DnsAddress, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : DnsAddress =
  let resp = srv.client.request("/organizations/"&globalid&"/dns", "POST", $$reqBody, queryParams=queryParams)
  return to[DnsAddress](resp.body)

proc UpdateOrganizationDns*(srv: Organizations_service, reqBody: DnsAddress, dnsname: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/dns/"&dnsname, "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteOrganizationDns*(srv: Organizations_service, dnsname: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/dns/"&dnsname, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc SetOrgMember*(srv: Organizations_service, reqBody: organizationsglobalidorgmembersPostReqBody, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/orgmembers", "POST", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc UpdateOrganizationOrgMemberShip*(srv: Organizations_service, reqBody: organizationsglobalidorgmembersPutReqBody, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : Organization =
  let resp = srv.client.request("/organizations/"&globalid&"/orgmembers", "PUT", $$reqBody, queryParams=queryParams)
  return to[Organization](resp.body)

proc AddIncludeSubOrgsOf*(srv: Organizations_service, reqBody: organizationsglobalidorgmembersincludesuborgsPostReqBody, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : organizationsglobalidorgmembersincludesuborgsPostRespBody =
  let resp = srv.client.request("/organizations/"&globalid&"/orgmembers/includesuborgs", "POST", $$reqBody, queryParams=queryParams)
  return to[organizationsglobalidorgmembersincludesuborgsPostRespBody](resp.body)

proc RemoveIncludeSubOrgsOf*(srv: Organizations_service, orgmember: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/orgmembers/includesuborgs/"&orgmember, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc AddOrganizationOrgMember*(srv: Organizations_service, reqBody: organizationsglobalidorgmembersinvitePostReqBody, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : JoinOrganizationInvitation =
  let resp = srv.client.request("/organizations/"&globalid&"/orgmembers/invite", "POST", $$reqBody, queryParams=queryParams)
  return to[JoinOrganizationInvitation](resp.body)

proc DeleteOrgMember*(srv: Organizations_service, globalid2: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/orgmembers/"&globalid2, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc AddOrganizationOwner*(srv: Organizations_service, reqBody: Member, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : Member =
  let resp = srv.client.request("/organizations/"&globalid&"/owners", "POST", $$reqBody, queryParams=queryParams)
  return to[Member](resp.body)

proc RemoveOrganizationOwner*(srv: Organizations_service, username: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/owners/"&username, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetOrganizationContracts*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/contracts", "GET", queryParams=queryParams)
  return to[string](resp.body)

proc CreateOrganizationContracty*(srv: Organizations_service, reqBody: Contract, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : Contract =
  let resp = srv.client.request("/organizations/"&globalid&"/contracts", "POST", $$reqBody, queryParams=queryParams)
  return to[Contract](resp.body)

proc ListOrganizationRegistry*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[RegistryEntry] =
  let resp = srv.client.request("/organizations/"&globalid&"/registry", "GET", queryParams=queryParams)
  return to[seq[RegistryEntry]](resp.body)

proc AddOrganizationRegistryEntry*(srv: Organizations_service, reqBody: RegistryEntry, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : RegistryEntry =
  let resp = srv.client.request("/organizations/"&globalid&"/registry", "POST", $$reqBody, queryParams=queryParams)
  return to[RegistryEntry](resp.body)

proc AddRequiredScope*(srv: Organizations_service, reqBody: RequiredScope, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/requiredscopes", "POST", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc UpdateRequiredScope*(srv: Organizations_service, requiredscope: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/requiredscopes/"&requiredscope, "PUT", queryParams=queryParams)
  return to[string](resp.body)

proc DeleteRequiredScope*(srv: Organizations_service, requiredscope: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/requiredscopes/"&requiredscope, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetOrganizationLogo*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/logo", "GET", queryParams=queryParams)
  return to[string](resp.body)

proc SetOrganizationLogo*(srv: Organizations_service, reqBody: organizationsglobalidlogoPutReqBody, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/logo", "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteOrganizationLogo*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/logo", "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc Get2faValidityTime*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : int =
  let resp = srv.client.request("/organizations/"&globalid&"/2fa/validity", "GET", queryParams=queryParams)
  return to[int](resp.body)

proc Set2faValidityTime*(srv: Organizations_service, reqBody: int, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/2fa/validity", "POST", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc AddOrganizationMember*(srv: Organizations_service, reqBody: Member, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : Member =
  let resp = srv.client.request("/organizations/"&globalid&"/members", "POST", $$reqBody, queryParams=queryParams)
  return to[Member](resp.body)

proc UpdateOrganizationMemberShip*(srv: Organizations_service, reqBody: Membership, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : Organization =
  let resp = srv.client.request("/organizations/"&globalid&"/members", "PUT", $$reqBody, queryParams=queryParams)
  return to[Organization](resp.body)

proc RemoveOrganizationMember*(srv: Organizations_service, username: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/members/"&username, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetOrganizationAPIKeyLabels*(srv: Organizations_service, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[string] =
  let resp = srv.client.request("/organizations/"&globalid&"/apikeys", "GET", queryParams=queryParams)
  return to[seq[string]](resp.body)

proc CreateNewOrganizationAPIKey*(srv: Organizations_service, reqBody: OrganizationAPIKey, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : OrganizationAPIKey =
  let resp = srv.client.request("/organizations/"&globalid&"/apikeys", "POST", $$reqBody, queryParams=queryParams)
  return to[OrganizationAPIKey](resp.body)

proc GetOrganizationAPIKey*(srv: Organizations_service, label: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : OrganizationAPIKey =
  let resp = srv.client.request("/organizations/"&globalid&"/apikeys/"&label, "GET", queryParams=queryParams)
  return to[OrganizationAPIKey](resp.body)

proc UpdateOrganizationAPIKey*(srv: Organizations_service, reqBody: organizationsglobalidapikeyslabelPutReqBody, label: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/apikeys/"&label, "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteOrganizationAPIKey*(srv: Organizations_service, label: string, globalid: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/organizations/"&globalid&"/apikeys/"&label, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

