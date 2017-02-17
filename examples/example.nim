import parseopt

import itsyouonline/client_itsyouonline, itsyouonline/Users_service
import itsyouonline/oauth2_client_oauth_2_0

proc main(clientID, clientSecret, username: string) =
  # create the client
  let c = client_itsyouonline.newClient()

  # get jwt token
  let jwtToken = c.getAccessToken(clientID, clientSecret, @[], @[])
  
  # set authorization header to use JWT token
  c.setAuthHeader("Bearer " & jwtToken)
  
  # let's try to call some API
  let uv = c.UsersSrv.GetUser("ibk")

when isMainModule:
  var clientID, clientSecret, username: string

  for kind, key, val in getOpt():
    case kind
    of cmdLongOption, cmdShortOption:
      case key
      of "client_id":
        clientID = val
      of "client_secret":
        clientSecret = val
      of "username":
        username = val
    else:
      discard

  if clientID.len == 0 or clientSecret.len == 0 or username.len == 0:
    echo("usage : ./example --client_id=YOUR_CLIENT_ID --client_secret=YOUR_CLIENT_SECRET --username=YOUR_USERNAME")
  else:
    main(clientID, clientSecret, username)
