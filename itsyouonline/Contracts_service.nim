import marshal, tables
import client_itsyouonline

import Contract
import Signature


type
  Contracts_service* = object
    client*: Client
    name*: string

proc ContractsSrv*(c : Client) : Contracts_service  =
  return Contracts_service(client:c, name:c.baseURI)


proc GetContract*(srv: Contracts_service, contractId: string, queryParams: Table[string, string] = initTable[string, string]()) : Contract =
  # Get a contract
  # It calls GET /contracts/{contractId} endpoint.

  let resp = srv.client.request("/contracts/"&contractId, "GET", queryParams=queryParams)
  return to[Contract](resp.body)

proc SignContract*(srv: Contracts_service, reqBody: Signature, contractId: string, queryParams: Table[string, string] = initTable[string, string]()) : string =
  # Sign a contract
  # It calls POST /contracts/{contractId}/signatures endpoint.

  let resp = srv.client.request("/contracts/"&contractId&"/signatures", "POST", $$reqBody, queryParams=queryParams)
  return to[string](resp.body)

