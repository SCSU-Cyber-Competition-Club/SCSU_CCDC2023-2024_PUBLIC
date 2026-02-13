| Port | Protocol                   | Usage                                                 | TCP/UDP |
| ---- | -------------------------- | ----------------------------------------------------- | ------- |
| 9997 | Splunk Forwarding          | Data forwarding from Universal Forwarders to Indexers | TCP     |
| 8089 | Splunk Management          | Management traffic (e.g., REST API communication)     | TCP     |
| 8000 | Web Interface              | Splunk Web interface for administrators               | TCP     |
| 514  | Syslog Input               | Receiving Syslog data (can be configured for both)    | TCP/UDP |
| 8088 | HTTP Event Collector (HEC) | Receiving data via HTTP/HTTPS                         | TCP     |
| 8191 | Inter-Splunk Communication | Splunk-to-Splunk communication in clusters            | TCP     |

|**Splunk Enterprise Ports**|**Splunk Component  <br>**|**Type**|**Description**|
|---|---|---|---|
|514|Syslog|Convention - Not Recommended|Syslog, TCP or UDP.  <br>Recommendation is to send Syslog to a Syslog Collector tool (Syslog-NG, rsyslog, etc) instead of to Splunk|
|8000|Web Interface|Default|Splunk Web (HTTP by Default)|
|8080, 9887|Indexers|Default|Indexer replication|
|8081, 8181, 9887|Search Heads|Default|SHC Replication|
|8088|HTTP Event Collector (HEC)|Default|Collects data sent to Splunk over HTTP|
|8089|Splunk|Default|Management port|
|8089|Indexers|Default|REST API Access|
|8089|Deployment Server|Default|Management port for Splunk deployment server.|
|8089|Search Heads|Default|Management port for Splunk search heads|
|8191|KVStore|Default|Internal and Replication|
|9997|Forwarders|Convention|Default forwarding port for sending data to indexers.|
|9998|Universal Forwarders and Indexers|Default|SSL communication between forwarders and indexers|