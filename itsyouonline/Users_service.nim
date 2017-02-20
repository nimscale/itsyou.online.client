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
import usersusernameapikeysPostReqBody
import usersusernameapikeyslabelPutReqBody
import usersusernamebanksPostReqBody
import usersusernamebanksPostRespBody
import usersusernamenamePutReqBody
import usersusernamenotificationsGetRespBody
import usersusernameorganizationsGetRespBody
import usersusernamepasswordPutReqBody
import usersusernamephonenumberslabelactivatePostRespBody
import usersusernamephonenumberslabelactivatePutReqBody
import usersusernametotpGetRespBody
import usersusernametotpPostReqBody
import usersusernametwofamethodsGetRespBody
import userview


type
  Users_service* = object
    client*: Client
    name*: string

proc UsersSrv*(c : Client) : Users_service  =
  return Users_service(client:c, name:c.baseURI)


proc CreateUser*(srv: Users_service, reqBody: User, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Create a new user
  # It calls POST /users endpoint.

  let resp = srv.client.request("/users", "POST", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc GetDigitalWallet*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[DigitalAssetAddress] =
  # List all of the user his digital wallets.
  # It calls GET /users/{username}/digitalwallet endpoint.

  let resp = srv.client.request("/users/"&username&"/digitalwallet", "GET", queryParams=queryParams)
  return to[seq[DigitalAssetAddress]](resp.body)

proc RegisterNewDigitalAssetAddress*(srv: Users_service, reqBody: DigitalAssetAddress, username: string, queryParams: Table[string, string] = initTable[string, string]()) : DigitalAssetAddress =
  # Register a new digital asset address
  # It calls POST /users/{username}/digitalwallet endpoint.

  let resp = srv.client.request("/users/"&username&"/digitalwallet", "POST", $$reqBody, queryParams=queryParams)
  return to[DigitalAssetAddress](resp.body)

proc GetDigitalAssetAddressByLabel*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : DigitalAssetAddress =
  # Get the details of a digital wallet address.
  # It calls GET /users/{username}/digitalwallet/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/digitalwallet/"&label, "GET", queryParams=queryParams)
  return to[DigitalAssetAddress](resp.body)

proc UpdateDigitalAssetAddress*(srv: Users_service, reqBody: DigitalAssetAddress, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Update the label and/or value of an existing address.
  # It calls PUT /users/{username}/digitalwallet/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/digitalwallet/"&label, "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteDigitalAssetAddress*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Removes an address
  # It calls DELETE /users/{username}/digitalwallet/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/digitalwallet/"&label, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetUserPhoneNumbers*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[Phonenumber] =
  # List of all of the user his phone numbers.
  # It calls GET /users/{username}/phonenumbers endpoint.

  let resp = srv.client.request("/users/"&username&"/phonenumbers", "GET", queryParams=queryParams)
  return to[seq[Phonenumber]](resp.body)

proc RegisterNewUserPhonenumber*(srv: Users_service, reqBody: Phonenumber, username: string, queryParams: Table[string, string] = initTable[string, string]()) : Phonenumber =
  # Register a new phonenumber
  # It calls POST /users/{username}/phonenumbers endpoint.

  let resp = srv.client.request("/users/"&username&"/phonenumbers", "POST", $$reqBody, queryParams=queryParams)
  return to[Phonenumber](resp.body)

proc GetUserPhonenumberByLabel*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : Phonenumber =
  # Get the details of a phone number.
  # It calls GET /users/{username}/phonenumbers/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/phonenumbers/"&label, "GET", queryParams=queryParams)
  return to[Phonenumber](resp.body)

proc UpdateUserPhonenumber*(srv: Users_service, reqBody: Phonenumber, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Update the label and/or value of an existing phonenumber.
  # It calls PUT /users/{username}/phonenumbers/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/phonenumbers/"&label, "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteUserPhonenumber*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Removes a phonenumber
  # It calls DELETE /users/{username}/phonenumbers/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/phonenumbers/"&label, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc ValidatePhonenumber*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : usersusernamephonenumberslabelactivatePostRespBody =
  # Sends a validation text message to the phone number.
  # It calls POST /users/{username}/phonenumbers/{label}/activate endpoint.

  let resp = srv.client.request("/users/"&username&"/phonenumbers/"&label&"/activate", "POST", queryParams=queryParams)
  return to[usersusernamephonenumberslabelactivatePostRespBody](resp.body)

proc VerifyPhoneNumber*(srv: Users_service, reqBody: usersusernamephonenumberslabelactivatePutReqBody, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Verifies a phone number
  # It calls PUT /users/{username}/phonenumbers/{label}/activate endpoint.

  let resp = srv.client.request("/users/"&username&"/phonenumbers/"&label&"/activate", "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc GetUserBankAccounts*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[BankAccount] =
  # List of the user his bank accounts.
  # It calls GET /users/{username}/banks endpoint.

  let resp = srv.client.request("/users/"&username&"/banks", "GET", queryParams=queryParams)
  return to[seq[BankAccount]](resp.body)

proc CreateUserBankAccount*(srv: Users_service, reqBody: usersusernamebanksPostReqBody, username: string, queryParams: Table[string, string] = initTable[string, string]()) : usersusernamebanksPostRespBody =
  # Create new bank account
  # It calls POST /users/{username}/banks endpoint.

  let resp = srv.client.request("/users/"&username&"/banks", "POST", $$reqBody, queryParams=queryParams)
  return to[usersusernamebanksPostRespBody](resp.body)

proc GetUserContracts*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Get the contracts where the user is 1 of the parties. Order descending by date.
  # It calls GET /users/{username}/contracts endpoint.

  let resp = srv.client.request("/users/"&username&"/contracts", "GET", queryParams=queryParams)
  return to[string](resp.body)

proc CreateUserContract*(srv: Users_service, reqBody: Contract, username: string, queryParams: Table[string, string] = initTable[string, string]()) : Contract =
  # Create a new contract.
  # It calls POST /users/{username}/contracts endpoint.

  let resp = srv.client.request("/users/"&username&"/contracts", "POST", $$reqBody, queryParams=queryParams)
  return to[Contract](resp.body)

proc GetAllAuthorizations*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[Authorization] =
  # Get the list of authorizations.
  # It calls GET /users/{username}/authorizations endpoint.

  let resp = srv.client.request("/users/"&username&"/authorizations", "GET", queryParams=queryParams)
  return to[seq[Authorization]](resp.body)

proc GetAuthorization*(srv: Users_service, grantedTo: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : Authorization =
  # Get the authorization for a specific organization.
  # It calls GET /users/{username}/authorizations/{grantedTo} endpoint.

  let resp = srv.client.request("/users/"&username&"/authorizations/"&grantedTo, "GET", queryParams=queryParams)
  return to[Authorization](resp.body)

proc UpdateAuthorization*(srv: Users_service, reqBody: Authorization, grantedTo: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Modify which information an organization is able to see.
  # It calls PUT /users/{username}/authorizations/{grantedTo} endpoint.

  let resp = srv.client.request("/users/"&username&"/authorizations/"&grantedTo, "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteAuthorization*(srv: Users_service, grantedTo: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Remove the authorization for an organization, the granted organization will no longer have access the user's information.
  # It calls DELETE /users/{username}/authorizations/{grantedTo} endpoint.

  let resp = srv.client.request("/users/"&username&"/authorizations/"&grantedTo, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetUser*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : User =
  
  # It calls GET /users/{username} endpoint.

  let resp = srv.client.request("/users/"&username, "GET", queryParams=queryParams)
  return to[User](resp.body)

proc UpdateUserName*(srv: Users_service, reqBody: usersusernamenamePutReqBody, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Update the user his firstname and lastname
  # It calls PUT /users/{username}/name endpoint.

  let resp = srv.client.request("/users/"&username&"/name", "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc UpdatePassword*(srv: Users_service, reqBody: usersusernamepasswordPutReqBody, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Update the user his password
  # It calls PUT /users/{username}/password endpoint.

  let resp = srv.client.request("/users/"&username&"/password", "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc ListAPIKeys*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[UserAPIKey] =
  # Lists the API keys
  # It calls GET /users/{username}/apikeys endpoint.

  let resp = srv.client.request("/users/"&username&"/apikeys", "GET", queryParams=queryParams)
  return to[seq[UserAPIKey]](resp.body)

proc AddApiKey*(srv: Users_service, reqBody: usersusernameapikeysPostReqBody, username: string, queryParams: Table[string, string] = initTable[string, string]()) : UserAPIKey =
  # Adds an APIKey to the user
  # It calls POST /users/{username}/apikeys endpoint.

  let resp = srv.client.request("/users/"&username&"/apikeys", "POST", $$reqBody, queryParams=queryParams)
  return to[UserAPIKey](resp.body)

proc GetAPIkey*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : UserAPIKey =
  # Get an API key by label
  # It calls GET /users/{username}/apikeys/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/apikeys/"&label, "GET", queryParams=queryParams)
  return to[UserAPIKey](resp.body)

proc UpdateAPIkey*(srv: Users_service, reqBody: usersusernameapikeyslabelPutReqBody, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Updates the label for the API key
  # It calls PUT /users/{username}/apikeys/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/apikeys/"&label, "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteAPIkey*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Removes an API key
  # It calls DELETE /users/{username}/apikeys/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/apikeys/"&label, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc ListUserRegistry*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[RegistryEntry] =
  # Lists the Registry entries
  # It calls GET /users/{username}/registry endpoint.

  let resp = srv.client.request("/users/"&username&"/registry", "GET", queryParams=queryParams)
  return to[seq[RegistryEntry]](resp.body)

proc AddUserRegistryEntry*(srv: Users_service, reqBody: RegistryEntry, username: string, queryParams: Table[string, string] = initTable[string, string]()) : RegistryEntry =
  # Adds a RegistryEntry to the user's registry, if the key is already used, it is overwritten.
  # It calls POST /users/{username}/registry endpoint.

  let resp = srv.client.request("/users/"&username&"/registry", "POST", $$reqBody, queryParams=queryParams)
  return to[RegistryEntry](resp.body)

proc GetUserRegistryEntry*(srv: Users_service, key: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : RegistryEntry =
  # Get a RegistryEntry from the user's registry.
  # It calls GET /users/{username}/registry/{key} endpoint.

  let resp = srv.client.request("/users/"&username&"/registry/"&key, "GET", queryParams=queryParams)
  return to[RegistryEntry](resp.body)

proc DeleteUserRegistryEntry*(srv: Users_service, key: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Removes a RegistryEntry from the user's registry
  # It calls DELETE /users/{username}/registry/{key} endpoint.

  let resp = srv.client.request("/users/"&username&"/registry/"&key, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetTwoFAMethods*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : usersusernametwofamethodsGetRespBody =
  # Get the possible two-factor authentication methods"
  # It calls GET /users/{username}/twofamethods endpoint.

  let resp = srv.client.request("/users/"&username&"/twofamethods", "GET", queryParams=queryParams)
  return to[usersusernametwofamethodsGetRespBody](resp.body)

proc GetTOTPSecret*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : usersusernametotpGetRespBody =
  # Get a TOTP secret and issuer that can be used for setting up two-factor authentication.
  # It calls GET /users/{username}/totp endpoint.

  let resp = srv.client.request("/users/"&username&"/totp", "GET", queryParams=queryParams)
  return to[usersusernametotpGetRespBody](resp.body)

proc SetupTOTP*(srv: Users_service, reqBody: usersusernametotpPostReqBody, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Enable two-factor authentication using TOTP.
  # It calls POST /users/{username}/totp endpoint.

  let resp = srv.client.request("/users/"&username&"/totp", "POST", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc RemoveTOTP*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Disable TOTP two-factor authentication.
  # It calls DELETE /users/{username}/totp endpoint.

  let resp = srv.client.request("/users/"&username&"/totp", "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetEmailAddresses*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[EmailAddress] =
  # Get a list of the user his email addresses.
  # It calls GET /users/{username}/emailaddresses endpoint.

  let resp = srv.client.request("/users/"&username&"/emailaddresses", "GET", queryParams=queryParams)
  return to[seq[EmailAddress]](resp.body)

proc RegisterNewEmailAddress*(srv: Users_service, reqBody: EmailAddress, username: string, queryParams: Table[string, string] = initTable[string, string]()) : EmailAddress =
  # Register a new email address
  # It calls POST /users/{username}/emailaddresses endpoint.

  let resp = srv.client.request("/users/"&username&"/emailaddresses", "POST", $$reqBody, queryParams=queryParams)
  return to[EmailAddress](resp.body)

proc UpdateEmailAddress*(srv: Users_service, reqBody: EmailAddress, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Updates the label and/or value of an email address
  # It calls PUT /users/{username}/emailaddresses/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/emailaddresses/"&label, "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteEmailAddress*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Removes an email address
  # It calls DELETE /users/{username}/emailaddresses/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/emailaddresses/"&label, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc ValidateEmailAddress*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Sends validation email to email address
  # It calls POST /users/{username}/emailaddresses/{label}/validate endpoint.

  let resp = srv.client.request("/users/"&username&"/emailaddresses/"&label&"/validate", "POST", queryParams=queryParams)
  return to[string](resp.body)

proc DeleteGithubAccount*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Unlink Github Account
  # It calls DELETE /users/{username}/github endpoint.

  let resp = srv.client.request("/users/"&username&"/github", "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc DeleteFacebookAccount*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Delete the associated facebook account
  # It calls DELETE /users/{username}/facebook endpoint.

  let resp = srv.client.request("/users/"&username&"/facebook", "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetUserInformation*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : userview =
  # Get all of the user his information. This will be limited to the scopes that the user has authorized. See https://gig.gitbooks.io/itsyouonline/content/oauth2/scopes.html and https://gig.gitbooks.io/itsyouonline/content/oauth2/availableScopes.html for more information.
  # It calls GET /users/{username}/info endpoint.

  let resp = srv.client.request("/users/"&username&"/info", "GET", queryParams=queryParams)
  return to[userview](resp.body)

proc GetUserAddresses*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[Address] =
  # List of all of the user his email addresses.
  # It calls GET /users/{username}/addresses endpoint.

  let resp = srv.client.request("/users/"&username&"/addresses", "GET", queryParams=queryParams)
  return to[seq[Address]](resp.body)

proc RegisterNewUserAddress*(srv: Users_service, reqBody: Address, username: string, queryParams: Table[string, string] = initTable[string, string]()) : Address =
  # Register a new address
  # It calls POST /users/{username}/addresses endpoint.

  let resp = srv.client.request("/users/"&username&"/addresses", "POST", $$reqBody, queryParams=queryParams)
  return to[Address](resp.body)

proc GetUserAddressByLabel*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : Address =
  # Get the details of an address.
  # It calls GET /users/{username}/addresses/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/addresses/"&label, "GET", queryParams=queryParams)
  return to[Address](resp.body)

proc UpdateUserAddress*(srv: Users_service, reqBody: Address, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Update the label and/or value of an existing address.
  # It calls PUT /users/{username}/addresses/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/addresses/"&label, "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteUserAddress*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Removes an address
  # It calls DELETE /users/{username}/addresses/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/addresses/"&label, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetUserBankAccountByLabel*(srv: Users_service, username: string, label: string, queryParams: Table[string, string] = initTable[string, string]()) : BankAccount =
  # Get the details of a bank account
  # It calls GET /users/{username}/banks/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/banks/"&label, "GET", queryParams=queryParams)
  return to[BankAccount](resp.body)

proc UpdateUserBankAccount*(srv: Users_service, reqBody: BankAccount, username: string, label: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Update an existing bankaccount and label.
  # It calls PUT /users/{username}/banks/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/banks/"&label, "PUT", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc DeleteUserBankAccount*(srv: Users_service, username: string, label: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Delete a BankAccount
  # It calls DELETE /users/{username}/banks/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/banks/"&label, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc GetNotifications*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : usersusernamenotificationsGetRespBody =
  # Get the list of notifications, these are pending invitations or approvals or other requests.
  # It calls GET /users/{username}/notifications endpoint.

  let resp = srv.client.request("/users/"&username&"/notifications", "GET", queryParams=queryParams)
  return to[usersusernamenotificationsGetRespBody](resp.body)

proc GetUserOrganizations*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : usersusernameorganizationsGetRespBody =
  # Get the list organizations a user is owner or member of
  # It calls GET /users/{username}/organizations endpoint.

  let resp = srv.client.request("/users/"&username&"/organizations", "GET", queryParams=queryParams)
  return to[usersusernameorganizationsGetRespBody](resp.body)

proc LeaveOrganization*(srv: Users_service, globalid: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Removes the user from an organization
  # It calls DELETE /users/{username}/organizations/{globalid}/leave endpoint.

  let resp = srv.client.request("/users/"&username&"/organizations/"&globalid&"/leave", "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc AcceptMembership*(srv: Users_service, reqBody: JoinOrganizationInvitation, role: string, globalid: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : JoinOrganizationInvitation =
  # Accept membership in organization
  # It calls POST /users/{username}/organizations/{globalid}/roles/{role} endpoint.

  let resp = srv.client.request("/users/"&username&"/organizations/"&globalid&"/roles/"&role, "POST", $$reqBody, queryParams=queryParams)
  return to[JoinOrganizationInvitation](resp.body)

proc usersByUsernameOrganizationsByGlobalidRolesByRoleDelete*(srv: Users_service, role: string, globalid: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Reject membership invitation in an organization.
  # It calls DELETE /users/{username}/organizations/{globalid}/roles/{role} endpoint.

  let resp = srv.client.request("/users/"&username&"/organizations/"&globalid&"/roles/"&role, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

proc ListPublicKeys*(srv: Users_service, username: string, queryParams: Table[string, string] = initTable[string, string]()) : seq[PublicKey] =
  # Lists all public keys
  # It calls GET /users/{username}/publickeys endpoint.

  let resp = srv.client.request("/users/"&username&"/publickeys", "GET", queryParams=queryParams)
  return to[seq[PublicKey]](resp.body)

proc AddPublicKey*(srv: Users_service, reqBody: PublicKey, username: string, queryParams: Table[string, string] = initTable[string, string]()) : PublicKey =
  # Add a public key
  # It calls POST /users/{username}/publickeys endpoint.

  let resp = srv.client.request("/users/"&username&"/publickeys", "POST", $$reqBody, queryParams=queryParams)
  return to[PublicKey](resp.body)

proc GetPublicKey*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : PublicKey =
  # Get a public key
  # It calls GET /users/{username}/publickeys/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/publickeys/"&label, "GET", queryParams=queryParams)
  return to[PublicKey](resp.body)

proc UpdatePublicKey*(srv: Users_service, reqBody: PublicKey, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : PublicKey =
  # Upates the label and/or key of an existing public key
  # It calls PUT /users/{username}/publickeys/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/publickeys/"&label, "PUT", $$reqBody, queryParams=queryParams)
  return to[PublicKey](resp.body)

proc DeletePublicKey*(srv: Users_service, label: string, username: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Delete a public key
  # It calls DELETE /users/{username}/publickeys/{label} endpoint.

  let resp = srv.client.request("/users/"&username&"/publickeys/"&label, "DELETE", queryParams=queryParams)
  return to[string](resp.body)

