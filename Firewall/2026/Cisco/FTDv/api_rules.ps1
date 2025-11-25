#########################################################################################
# 1. Receiving authentication token with hardcoded creds, because best practice is for losers

#POST body
$body = "grant_type=password&username=admin&password=Yahwehy4hweh!"

#make POST request, receiving raw response that includes auth token
$tok_req = curl.exe -k `
    -X POST "https://192.168.254.136/api/fdm/latest/fdm/token" `
    -H "Content-Type: application/x-www-form-urlencoded" `
    -d $body

# JSON response --> Pshell object
$tok_conv = $tok_req | ConvertFrom-Json
#token is the object's "access_token" property
$token = $tok_conv.access_token
#########################################################################################

# 2. Receiving policy ID of the policy we'll be adding rules to using the auth token

#make request, receive raw response
$id_req = curl.exe -k -H "Authorization: Bearer $token" `
    -H "Accept: application/json" `
    "https://192.168.254.136/api/fdm/latest/policy/accesspolicies"


$id_conv = $id_req | ConvertFrom-Json

$id = $id_conv.items[0].id
#########################################################################################
# 3. (OPTIONAL) get rules
# not needed, but very useful when building your script; manually create a rule you want in the GUI, then make this call to get its JSON; copy and paste that JSON into your script
# YOU WILL NEED to remove a couple lines towards the bottom; the "id" and "links" lines
$headers = @{
    "Content-Type"  = "application/json"
    "Authorization" = "Bearer $token"
}

$fdmIp = "192.168.254.136"
$url = "https://$fdmIp/api/fdm/latest/policy/accesspolicies/$id/accessrules"


$rulesResponse = curl.exe -k -X GET $url -H "Authorization: Bearer $token" -H "Content-Type: application/json" | Out-File -FilePath C:\Users\Carl\Desktop\json.txt
#########################################################################################
# 4. post layer 3 rule

#JSON of the rule to be posted, as a here-string
$lay3 = @'
    {
    "version": "cq6p3v5j6nmpi",
    "name" :"APITEST",
    "ruleId": 268435460,
    "sourceZones": [ {
      "version": "nkmp6fumvhuod",
      "name": "inside_zone",
      "id": "90c377e0-b3e5-11e5-8db8-651556da7898",
      "type": "securityzone"
    } ],
    "destinationZones": [ {
      "version": "ncnwv3kkpswwu",
      "name": "outside_zone",
      "id": "b1af33e1-b3e5-11e5-8db8-afdc0be5453e",
      "type": "securityzone"
    } ],
    "sourceNetworks": [ {
      "version": "dd7sm6n6jpcbf",
      "name": "any-ipv4",
      "id": "0078c18e-bb65-11f0-a92b-e3fa953e3159",
      "type": "networkobject"
    } ],
    "destinationNetworks": [ {
      "version": "dd7sm6n6jpcbf",
      "name": "any-ipv4",
      "id": "0078c18e-bb65-11f0-a92b-e3fa953e3159",
      "type": "networkobject"
    } ],
    "sourcePorts": [ {
      "version": "oojwr2ywq2ter",
      "name": "SNMP",
      "id": "1834c264-38bb-11e2-86aa-62f0c593a59a",
      "type": "udpportobject"
    } ],
    "destinationPorts": [ ],
    "ruleAction": "PERMIT",
    "eventLogAction": "LOG_NONE",
    "identitySources": [ ],
    "users": [ ],
    "embeddedAppFilter": null,
    "urlFilter": {
      "urlObjects": [ ],
      "urlCategories": [ ],
      "type": "embeddedurlfilter"
    },
    "intrusionPolicy": null,
    "filePolicy": null,
    "logFiles": false,
    "syslogServer": null,
    "destinationDynamicObjects": [ ],
    "sourceDynamicObjects": [ ],
    "timeRangeObjects": [ ],
    "type": "accessrule"
    }
   

'@

# Powershell is <bad word>, so you need to pass the here-string into a file, and then call the file in your curl request
# Otherwise, Powershell will be "helpful" and mangle the contents of the here-string by removing quotes, breaking the JSON
# "But, Carl, either way we're creating a here-string of the rule's JSON and that's being passed to curl, why does adding an extra step of passing it to a file work?"
# BECAUSE POWERSHELL IS <BAD WORD>.
$lay3 | Out-File -FilePath C:\Users\Carl\Desktop\body.json -Encoding utf8

curl.exe -k -X POST $url `
 -H "Authorization: Bearer $token" `
 -H "Content-Type: application/json" `
 -d @C:\Users\Carl\Desktop\body.json

 #########################################################################################
 # 5. post layer 7 rule
 # unfortunately, you WILL need to do it like this and have each rule added in its own POST request. FDM only supports adding one rule per POST



 $lay7 = @'
 {
    "version" : "ibtbslcqcqj6a",
    "name" : "LAYER7",
    "ruleId" : 268435462,
    "sourceZones" : [ {
      "version" : "nkmp6fumvhuod",
      "name" : "inside_zone",
      "id" : "90c377e0-b3e5-11e5-8db8-651556da7898",
      "type" : "securityzone"
    } ],
    "destinationZones" : [ {
      "version" : "ncnwv3kkpswwu",
      "name" : "outside_zone",
      "id" : "b1af33e1-b3e5-11e5-8db8-afdc0be5453e",
      "type" : "securityzone"
    } ],
    "sourceNetworks" : [ {
      "version" : "dd7sm6n6jpcbf",
      "name" : "any-ipv4",
      "id" : "0078c18e-bb65-11f0-a92b-e3fa953e3159",
      "type" : "networkobject"
    } ],
    "destinationNetworks" : [ {
      "version" : "dd7sm6n6jpcbf",
      "name" : "any-ipv4",
      "id" : "0078c18e-bb65-11f0-a92b-e3fa953e3159",
      "type" : "networkobject"
    } ],
    "sourcePorts" : [ ],
    "destinationPorts" : [ ],
    "ruleAction" : "PERMIT",
    "eventLogAction" : "LOG_NONE",
    "identitySources" : [ ],
    "users" : [ ],
    "embeddedAppFilter" : {
      "applications" : [ {
        "name" : "HTTPS",
        "appId" : 1122,
        "id" : "faac128f-bb64-11f0-a92b-65a2dea34f35",
        "type" : "application"
      } ],
      "applicationFilters" : [ ],
      "conditions" : [ ],
      "type" : "embeddedappfilter"
    },
    "urlFilter" : {
      "urlObjects" : [ ],
      "urlCategories" : [ ],
      "type" : "embeddedurlfilter"
    },
    "intrusionPolicy" : null,
    "filePolicy" : null,
    "logFiles" : false,
    "syslogServer" : null,
    "destinationDynamicObjects" : [ ],
    "sourceDynamicObjects" : [ ],
    "timeRangeObjects" : [ ],
    "type" : "accessrule"
  }
'@

$lay7 | Out-File -FilePath C:\Users\Carl\Desktop\body2.json -Encoding utf8

curl.exe -k -X POST $url `
 -H "Authorization: Bearer $token" `
 -H "Content-Type: application/json" `
 -d @C:\Users\Carl\Desktop\body2.json