`api_rules.sh` demonstrates everything you'll need to add rules through the API with a script.
Before getting to that, though: THIS WILL NOT WORK OFF THE BAT IN THE COMPETITION. API access was restricted; it must be enabled.

As documented in its commentation, `api_rules.sh` does the following:
1. Authenticates to the API, granting a temporary authntication token needed for further requests (such as adding rules)
2. Grabs the policy ID of the policy we're adding rules to. (Alternatively, this could be done prior to the competition during sprint week once we have access to the competition environment, as this ID will not change; the ID could be hardcoded into your script)
3. Grabs the full JSON of your policy, including rules. This is not needed within the competition. However, as you'll need the JSON for a rule you want to create, this simplifies this task. Create the rule manually in the FDM GUI, then make this call to get its JSON; copy and paste the JSON into the next step. YOU WILL NEED TO REMOVE A COUPLE LINES:
  - the "id": line towards the bottom, and
  - the "links" lines towards the bottom
4. POSTs a layer 3 rule
5. POSTs a layer 7 rule

Ideally, create layer 7 rules rather than layer 3 when possible.
Sadly, FDM only supports the addition of a single rule per POST request.
     
