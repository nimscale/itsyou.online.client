import marshal, tables
import client_itsyouonline

import Company
import Contract
import companyview


type
  Companies_service* = object
    client*: Client
    name*: string

proc CompaniesSrv*(c : Client) : Companies_service  =
  return Companies_service(client:c, name:c.baseURI)


proc GetCompanyList*(srv: Companies_service, queryParams: Table[string, string] = initTable[string, string]()) : seq[Company] =
  # Get companies. Authorization limits are applied to requesting user.
  # It calls GET /companies endpoint.

  let resp = srv.client.request("/companies", "GET", queryParams=queryParams)
  return to[seq[Company]](resp.body)

proc CreateCompany*(srv: Companies_service, reqBody: Company, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Register a new company
  # It calls POST /companies endpoint.

  let resp = srv.client.request("/companies", "POST", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc GetCompany*(srv: Companies_service, globalId: string, queryParams: Table[string, string] = initTable[string, string]()) : Company =
  # Get organization info
  # It calls GET /companies/{globalId} endpoint.

  let resp = srv.client.request("/companies/"&globalId, "GET", queryParams=queryParams)
  return to[Company](resp.body)

proc UpdateCompany*(srv: Companies_service, globalId: string, queryParams: Table[string, string] = initTable[string, string]()) : Company =
  # Update existing company. Updating ``globalId`` is not allowed.
  # It calls PUT /companies/{globalId} endpoint.

  let resp = srv.client.request("/companies/"&globalId, "PUT", queryParams=queryParams)
  return to[Company](resp.body)

proc companiesByGlobalIdValidateGet*(srv: Companies_service, globalId: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  
  # It calls GET /companies/{globalId}/validate endpoint.

  let resp = srv.client.request("/companies/"&globalId&"/validate", "GET", queryParams=queryParams)
  return to[string](resp.body)

proc GetCompanyContracts*(srv: Companies_service, globalId: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Get the contracts where the organization is 1 of the parties. Order descending by date.
  # It calls GET /companies/{globalId}/contracts endpoint.

  let resp = srv.client.request("/companies/"&globalId&"/contracts", "GET", queryParams=queryParams)
  return to[string](resp.body)

proc CreateCompanyContract*(srv: Companies_service, reqBody: Contract, globalId: string, queryParams: Table[string, string] = initTable[string, string]()) : Contract =
  # Create a new contract.
  # It calls POST /companies/{globalId}/contracts endpoint.

  let resp = srv.client.request("/companies/"&globalId&"/contracts", "POST", $$reqBody, queryParams=queryParams)
  return to[Contract](resp.body)

proc GetCompanyInfo*(srv: Companies_service, globalId: string, queryParams: Table[string, string] = initTable[string, string]()) : companyview =
  
  # It calls GET /companies/{globalId}/info endpoint.

  let resp = srv.client.request("/companies/"&globalId&"/info", "GET", queryParams=queryParams)
  return to[companyview](resp.body)

