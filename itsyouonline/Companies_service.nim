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
  let resp = srv.client.request("/companies", "GET", queryParams=queryParams)
  return to[seq[Company]](resp.body)

proc CreateCompany*(srv: Companies_service, reqBody: Company, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/companies", "POST", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

proc GetCompany*(srv: Companies_service, globalId: string, queryParams: Table[string, string] = initTable[string, string]()) : Company =
  let resp = srv.client.request("/companies/"&globalId, "GET", queryParams=queryParams)
  return to[Company](resp.body)

proc UpdateCompany*(srv: Companies_service, globalId: string, queryParams: Table[string, string] = initTable[string, string]()) : Company =
  let resp = srv.client.request("/companies/"&globalId, "PUT", queryParams=queryParams)
  return to[Company](resp.body)

proc GetCompanyInfo*(srv: Companies_service, globalId: string, queryParams: Table[string, string] = initTable[string, string]()) : companyview =
  let resp = srv.client.request("/companies/"&globalId&"/info", "GET", queryParams=queryParams)
  return to[companyview](resp.body)

proc companiesByGlobalIdValidateGet*(srv: Companies_service, globalId: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/companies/"&globalId&"/validate", "GET", queryParams=queryParams)
  return to[string](resp.body)

proc GetCompanyContracts*(srv: Companies_service, globalId: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  let resp = srv.client.request("/companies/"&globalId&"/contracts", "GET", queryParams=queryParams)
  return to[string](resp.body)

proc CreateCompanyContract*(srv: Companies_service, reqBody: Contract, globalId: string, queryParams: Table[string, string] = initTable[string, string]()) : Contract =
  let resp = srv.client.request("/companies/"&globalId&"/contracts", "POST", $$reqBody, queryParams=queryParams)
  return to[Contract](resp.body)

