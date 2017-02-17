
import Label
type
  BankAccount* = object
    bic*: string
    country*: string
    iban*: string
    label*: Label
