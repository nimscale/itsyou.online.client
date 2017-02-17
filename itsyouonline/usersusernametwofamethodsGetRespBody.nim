
import Phonenumber
type
  usersusernametwofamethodsGetRespBody* = object
    sms*: seq[Phonenumber]
    totp*: bool
