1. Gather IOCs and Understand the Goal

- Know what to hunt: Collect IOCs such as:

      a. IP address                       

      b. Domains		    

      c. Hashes		 

      d. File Paths

Make sure Splunk indexes are accessible.

2. Hunt for IOCs

- Check for Active Sourcetypes

Quickly identify the most active sourcetypes in the environments:

      Spl:    | metadata type=sourcetypes sort - totalCount

Search for Ip addresses

- Check for malicious source or destination IPs:

      Spl: 	index=* (src_ip=192.168.1.1 OR dest_Ip=192.168.1.1)

Or use multiple Ips:

       Spl:      index=* src_ip IN (192.168.1.1, 10.0.0.5)

Search for Domains

- Look for DNS queries to known bad domains:

      Spl:    index=dns dns_query IN ("evilsite.com", "phishing.net")

Search for File Hashes

- Hunt for file hashes in logs:

      Spl:     index=* file_hash IN ("e99a18c428cb38d5f260853678922e03")

Search for Malicious URL

- Identify bad URLs accessed:

      Spl:   index=web url IN ("http://evilsite.com", "http://phishing.net")

Search for File Path

- Locate suspicious files or executables:

      Spl:   index=* file_path IN ("/tmp/malware.sh", "C:\\Windows\\bad.exe")

Note: The IPs, dn_query, file_sha, URL, and file_path provided are just examples. Be sure to replace them with your own.

3. Use Lookups for Threat Intelligence

- Match Ips or domains with internal/external threat intel:

      Spl:    index=* | lookup threatintel_lookup ip AS src_ip OUTPUTNEW threat_score threat_description

Spot Rare or Unusual Activity

- Find rarely seen Ips, domains, or actions:

       Spl:  index=* | rare src_ip

Track Activity Over Time

- Use a timechart to visualize patterns:

      Spl: index=* src_ip=192.168.1.1 | timechart count by dest_ip

Look Closer

- Check specific IOC activity for more details:

      Spl:  index=* src_ip=192.168.1.1 | stats count by _time dest_ip action

4. Save Your Work

Save Searches: Create reusable searches for IOCs to avoid repeating work.

    - In Splunk Web, click Save As > Report.

Set Alerts: Get notified if IOCs appear again

      Spl: index=* src_ip=192.168.1.1 | stats count

Note: The IPs, dn_query, file_sha, URL, and file_path provided are just examples. Be sure to replace them with your own.

