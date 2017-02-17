
import RequiredScope
type
  Organization* = object
    dns*: seq[string]
    globalid*: string
    includes*: seq[string]
    includesuborgsof*: seq[string]
    members*: seq[string]
    orgmembers*: seq[string]
    orgowners*: seq[string]
    owners*: seq[string]
    publicKeys*: seq[string]
    requiredscopes*: seq[RequiredScope]
