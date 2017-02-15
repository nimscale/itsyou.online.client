
import Label
import times
type
  DigitalAssetAddress* = object
    address*: string
    currencysymbol*: string
    expire*: Time
    label*: Label
    noexpiration*: bool
