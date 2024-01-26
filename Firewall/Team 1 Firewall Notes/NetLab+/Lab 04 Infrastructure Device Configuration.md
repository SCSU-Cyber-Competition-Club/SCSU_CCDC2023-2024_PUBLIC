
Example of Zone Segmentation

| NAME            | TAGS         | TYPE       | SOURCE ZONE | SOURCE ADDRESS | SOURCE USER    | SOURCE DEVICE | DESTINATION ZONE | DESTINATION ADDRESS | DESTINATION DEVICE | APPLICATION | SERVICE            | ACTION |
|-----------------|--------------|------------|-------------|----------------|----------------|---------------|------------------|---------------------|--------------------|-------------|--------------------|--------|
| B2B-PCI-Access  | B2B          | universal  | B2B         | any            | Bob            | any           | PCI              | any                 | any                | mssql-db    | application-default | Allow  |
| Acct-PCI-Access | Accounting   | universal  | Accounting  | any            | Accounting_Grp | any           | PCI              | any                 | any                | mssql-db    | application-default | Allow  |
| intrazone-default | none       | intrazone  | any         | any            | any            | any           | (intrazone)      | any                 | any                | any         | any                | Allow  |
| interzone-default | none       | interzone  | any         | any            | any            | any           | any              | any                 | any                | any         | any                | Deny   |

Example
- Create a Security policy rule to allow required interzone traffic:
- Bob in the B2B zone is allowed to access the PCI zone.
- The Accounting-Grp in the Accounting zone is allowed to access the PCI zone.
- Any other interzone traffic is blocked, by default