
import Address
import BankAccount
import EmailAddress
import FacebookAccount
import GithubAccount
import Phonenumber
import PublicKey
type
  userview* = object
    addresses*: seq[Address]
    bankaccounts*: seq[BankAccount]
    emailaddresses*: seq[EmailAddress]
    facebook*: FacebookAccount
    github*: GithubAccount
    organizations*: seq[string]
    phonenumbers*: seq[Phonenumber]
    publicKeys*: seq[PublicKey]
    username*: string
