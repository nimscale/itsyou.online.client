import marshal, tables
import client_itsyouonline

import Address
import Authorization
import BankAccount
import Contract
import DigitalAssetAddress
import EmailAddress
import JoinOrganizationInvitation
import Phonenumber
import PublicKey
import RegistryEntry
import User
import UserAPIKey
import userview


type
  Users_service* = object
    client*: Client
    name*: string

proc UsersSrv*(c : Client) : Users_service  =
  return Users_service(client:c, name:c.baseURI)


proc CreateUser*(srv: Users_service, reqBody: User, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users", "POST", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc GetUserInformation*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : userview =
  let resp = srv.client.request("/users/"&username&"/info", "GET", queryParams=queryParams)
  return to[userview](resp.body)

proc GetAllAuthorizations*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[Authorization] =
  let resp = srv.client.request("/users/"&username&"/authorizations", "GET", queryParams=queryParams)
  return to[seq[Authorization]](resp.body)

proc GetAuthorization*(srv: Users_service, grantedTo: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : Authorization =
  let resp = srv.client.request("/users/"&username&"/authorizations/"&grantedTo, "GET", queryParams=queryParams)
  return to[Authorization](resp.body)

proc UpdateAuthorization*(srv: Users_service, reqBody: Authorization, grantedTo: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/authorizations/"&grantedTo, "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteAuthorization*(srv: Users_service, grantedTo: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/authorizations/"&grantedTo, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetUserOrganizations*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : usersusernameorganizationsGetRespBody =
  let resp = srv.client.request("/users/"&username&"/organizations", "GET", queryParams=queryParams)
  return to[usersusernameorganizationsGetRespBody](resp.body)

proc LeaveOrganization*(srv: Users_service, globalid: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/organizations/"&globalid&"/leave", "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc AcceptMembership*(srv: Users_service, reqBody: JoinOrganizationInvitation, role: string, globalid: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : JoinOrganizationInvitation =
  let resp = srv.client.request("/users/"&username&"/organizations/"&globalid&"/roles/"&role, "POST", $$reqBody, queryParams=queryParams)
  return to[JoinOrganizationInvitation](resp.body)

proc usersByUsernameOrganizationsByGlobalidRolesByRoleDelete*(srv: Users_service, role: string, globalid: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/organizations/"&globalid&"/roles/"&role, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetNotifications*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : usersusernamenotificationsGetRespBody =
  let resp = srv.client.request("/users/"&username&"/notifications", "GET", queryParams=queryParams)
  return to[usersusernamenotificationsGetRespBody](resp.body)

proc GetUserContracts*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/contracts", "GET", queryParams=queryParams)
  return to[string](resp.body)

proc CreateUserContract*(srv: Users_service, reqBody: Contract, username: string, queryParams: Table[string, string] = initTable[string, string]()) : Contract =
  let resp = srv.client.request("/users/"&username&"/contracts", "POST", $$reqBody, queryParams=queryParams)
  return to[Contract](resp.body)

proc GetUser*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : User =
  let resp = srv.client.request("/users/"&username, "GET", queryParams=queryParams)
  return to[User](resp.body)

proc ListUserRegistry*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[RegistryEntry] =
  let resp = srv.client.request("/users/"&username&"/registry", "GET", queryParams=queryParams)
  return to[seq[RegistryEntry]](resp.body)

proc AddUserRegistryEntry*(srv: Users_service, reqBody: RegistryEntry, username: string, queryParams: Table[string, string] = initTable[string, string]()) : RegistryEntry =
  let resp = srv.client.request("/users/"&username&"/registry", "POST", $$reqBody, queryParams=queryParams)
  return to[RegistryEntry](resp.body)

proc GetUserRegistryEntry*(srv: Users_service, key: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : RegistryEntry =
  let resp = srv.client.request("/users/"&username&"/registry/"&key, "GET", queryParams=queryParams)
  return to[RegistryEntry](resp.body)

proc DeleteUserRegistryEntry*(srv: Users_service, key: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/registry/"&key, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc DeleteGithubAccount*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/github", "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc DeleteFacebookAccount*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/facebook", "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetTOTPSecret*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : usersusernametotpGetRespBody =
  let resp = srv.client.request("/users/"&username&"/totp", "GET", queryParams=queryParams)
  return to[usersusernametotpGetRespBody](resp.body)

proc SetupTOTP*(srv: Users_service, reqBody: usersusernametotpPostReqBody, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/totp", "POST", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc RemoveTOTP*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/totp", "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc UpdateUserName*(srv: Users_service, reqBody: usersusernamenamePutReqBody, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/name", "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc GetEmailAddresses*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[EmailAddress] =
  let resp = srv.client.request("/users/"&username&"/emailaddresses", "GET", queryParams=queryParams)
  return to[seq[EmailAddress]](resp.body)

proc RegisterNewEmailAddress*(srv: Users_service, reqBody: EmailAddress, username: string, queryParams: Table[string, string] = initTable[string, string]()) : EmailAddress =
  let resp = srv.client.request("/users/"&username&"/emailaddresses", "POST", $$reqBody, queryParams=queryParams)
  return to[EmailAddress](resp.body)

proc UpdateEmailAddress*(srv: Users_service, reqBody: EmailAddress, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/emailaddresses/"&label, "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteEmailAddress*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/emailaddresses/"&label, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc ValidateEmailAddress*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/emailaddresses/"&label&"/validate", "POST", queryParams=queryParams)
  return to[string](resp.body)

proc ListAPIKeys*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[UserAPIKey] =
  let resp = srv.client.request("/users/"&username&"/apikeys", "GET", queryParams=queryParams)
  return to[seq[UserAPIKey]](resp.body)

proc AddApiKey*(srv: Users_service, reqBody: usersusernameapikeysPostReqBody, username: string, queryParams: Table[string, string] = initTable[string, string]()) : UserAPIKey =
  let resp = srv.client.request("/users/"&username&"/apikeys", "POST", $$reqBody, queryParams=queryParams)
  return to[UserAPIKey](resp.body)

proc GetAPIkey*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : UserAPIKey =
  let resp = srv.client.request("/users/"&username&"/apikeys/"&label, "GET", queryParams=queryParams)
  return to[UserAPIKey](resp.body)

proc UpdateAPIkey*(srv: Users_service, reqBody: usersusernameapikeyslabelPutReqBody, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/apikeys/"&label, "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteAPIkey*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/apikeys/"&label, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetTwoFAMethods*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : usersusernametwofamethodsGetRespBody =
  let resp = srv.client.request("/users/"&username&"/twofamethods", "GET", queryParams=queryParams)
  return to[usersusernametwofamethodsGetRespBody](resp.body)

proc UpdatePassword*(srv: Users_service, reqBody: usersusernamepasswordPutReqBody, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/password", "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc GetUserAddresses*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[Address] =
  let resp = srv.client.request("/users/"&username&"/addresses", "GET", queryParams=queryParams)
  return to[seq[Address]](resp.body)

proc RegisterNewUserAddress*(srv: Users_service, reqBody: Address, username: string, queryParams: Table[string, string] = initTable[string, string]()) : Address =
  let resp = srv.client.request("/users/"&username&"/addresses", "POST", $$reqBody, queryParams=queryParams)
  return to[Address](resp.body)

proc GetUserAddressByLabel*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : Address =
  let resp = srv.client.request("/users/"&username&"/addresses/"&label, "GET", queryParams=queryParams)
  return to[Address](resp.body)

proc UpdateUserAddress*(srv: Users_service, reqBody: Address, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/addresses/"&label, "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteUserAddress*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/addresses/"&label, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetDigitalWallet*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[DigitalAssetAddress] =
  let resp = srv.client.request("/users/"&username&"/digitalwallet", "GET", queryParams=queryParams)
  return to[seq[DigitalAssetAddress]](resp.body)

proc RegisterNewDigitalAssetAddress*(srv: Users_service, reqBody: DigitalAssetAddress, username: string, queryParams: Table[string, string] = initTable[string, string]()) : DigitalAssetAddress =
  let resp = srv.client.request("/users/"&username&"/digitalwallet", "POST", $$reqBody, queryParams=queryParams)
  return to[DigitalAssetAddress](resp.body)

proc GetDigitalAssetAddressByLabel*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : DigitalAssetAddress =
  let resp = srv.client.request("/users/"&username&"/digitalwallet/"&label, "GET", queryParams=queryParams)
  return to[DigitalAssetAddress](resp.body)

proc UpdateDigitalAssetAddress*(srv: Users_service, reqBody: DigitalAssetAddress, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/digitalwallet/"&label, "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteDigitalAssetAddress*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/digitalwallet/"&label, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetUserPhoneNumbers*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[Phonenumber] =
  let resp = srv.client.request("/users/"&username&"/phonenumbers", "GET", queryParams=queryParams)
  return to[seq[Phonenumber]](resp.body)

proc RegisterNewUserPhonenumber*(srv: Users_service, reqBody: Phonenumber, username: string, queryParams: Table[string, string] = initTable[string, string]()) : Phonenumber =
  let resp = srv.client.request("/users/"&username&"/phonenumbers", "POST", $$reqBody, queryParams=queryParams)
  return to[Phonenumber](resp.body)

proc GetUserPhonenumberByLabel*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : Phonenumber =
  let resp = srv.client.request("/users/"&username&"/phonenumbers/"&label, "GET", queryParams=queryParams)
  return to[Phonenumber](resp.body)

proc UpdateUserPhonenumber*(srv: Users_service, reqBody: Phonenumber, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/phonenumbers/"&label, "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteUserPhonenumber*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/phonenumbers/"&label, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc ValidatePhonenumber*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : usersusernamephonenumberslabelactivatePostRespBody =
  let resp = srv.client.request("/users/"&username&"/phonenumbers/"&label&"/activate", "POST", queryParams=queryParams)
  return to[usersusernamephonenumberslabelactivatePostRespBody](resp.body)

proc VerifyPhoneNumber*(srv: Users_service, reqBody: usersusernamephonenumberslabelactivatePutReqBody, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/phonenumbers/"&label&"/activate", "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc GetUserBankAccounts*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[BankAccount] =
  let resp = srv.client.request("/users/"&username&"/banks", "GET", queryParams=queryParams)
  return to[seq[BankAccount]](resp.body)

proc CreateUserBankAccount*(srv: Users_service, reqBody: usersusernamebanksPostReqBody, username: string, queryParams: Table[string, string] = initTable[string, string]()) : usersusernamebanksPostRespBody =
  let resp = srv.client.request("/users/"&username&"/banks", "POST", $$reqBody, queryParams=queryParams)
  return to[usersusernamebanksPostRespBody](resp.body)

proc GetUserBankAccountByLabel*(srv: Users_service, username: string, label: string, queryParams: Table[string, string] = initTable[string, string]()) : BankAccount =
  let resp = srv.client.request("/users/"&username&"/banks/"&label, "GET", queryParams=queryParams)
  return to[BankAccount](resp.body)

proc UpdateUserBankAccount*(srv: Users_service, reqBody: BankAccount, username: string, label: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/banks/"&label, "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteUserBankAccount*(srv: Users_service, username: string, label: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/banks/"&label, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc ListPublicKeys*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[PublicKey] =
  let resp = srv.client.request("/users/"&username&"/publickeys", "GET", queryParams=queryParams)
  return to[seq[PublicKey]](resp.body)

proc AddPublicKey*(srv: Users_service, reqBody: PublicKey, username: string, queryParams: Table[string, string] = initTable[string, string]()) : PublicKey =
  let resp = srv.client.request("/users/"&username&"/publickeys", "POST", $$reqBody, queryParams=queryParams)
  return to[PublicKey](resp.body)

proc GetPublicKey*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : PublicKey =
  let resp = srv.client.request("/users/"&username&"/publickeys/"&label, "GET", queryParams=queryParams)
  return to[PublicKey](resp.body)

proc UpdatePublicKey*(srv: Users_service, reqBody: PublicKey, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : PublicKey =
  let resp = srv.client.request("/users/"&username&"/publickeys/"&label, "PUT", $$reqBody, queryParams=queryParams)
  return to[PublicKey](resp.body)

proc DeletePublicKey*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/users/"&username&"/publickeys/"&label, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

