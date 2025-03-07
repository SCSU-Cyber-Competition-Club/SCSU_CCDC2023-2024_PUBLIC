

curl.exe -k -X POST "https://10.0.0.3/api/?type=keygen&user=admin&password=P@ssw0rd"


https://docs.paloaltonetworks.com/pan-os/11-0/pan-os-panorama-api/get-started-with-the-pan-os-rest-api/create-security-policy-rule-rest-api

https://docs.paloaltonetworks.com/pan-os/11-0/pan-os-panorama-api/get-started-with-the-pan-os-xml-api/enable-api-access#ide6063ba8-2b0b-42eb-98c2-eb4914061722



curl -k -X POST --data-binary @address.xml "https://<FIREWALL_IP>/api/?key=<API_KEY>&type=config&action=set&xpath=/config/devices/entry[@name='localhost.localdomain']/vsys/entry[@name='vsys1']/address"


curl -k -X POST "https://<FIREWALL_IP>/api/?key=<API_KEY>&type=config&action=set&xpath=/config/devices/entry[@name='localhost.localdomain']/vsys/entry[@name='vsys1']/address/entry[@name='<ADDRESS_NAME>']&element=<ip-netmask><IP_ADDRESS></ip-netmask>"




{
  "@status": "success",
  "@code": "19",
  "result": {
    "@total-count": "7",
    "@count": "7",
    "entry": [
      {
        "@name": "public_int",
        "@location": "vsys",
        "@vsys": "vsys1",
        "ip-netmask": "172.20.241.254/24"
      },
      {
        "@name": "internal_int",
        "@location": "vsys",
        "@vsys": "vsys1",
        "ip-netmask": "172.20.250.254/24"
      },
      {
        "@name": "isp_int",
        "@location": "vsys",
        "@vsys": "vsys1",
        "ip-netmask": "10.0.0.6/24"
      },
      {
        "@name": "user_int",
        "@location": "vsys",
        "@vsys": "vsys1",
        "ip-netmask": "172.20.242.254/24"
      },
      {
        "@name": "user",
        "@location": "vsys",
        "@vsys": "vsys1",
        "ip-netmask": "172.20.242.0/24"
      },
      {
        "@name": "public",
        "@location": "vsys",
        "@vsys": "vsys1",
        "ip-netmask": "172.20.241.254/24"
      },
      {
        "@name": "internal",
        "@location": "vsys",
        "@vsys": "vsys1",
        "ip-netmask": "172.20.240.0/24"
      }
    ]
  }
}****






{
  "@status": "success",
  "@code": "19",
  "result": {
    "@total-count": "2",
    "@count": "2",
    "entry": [
      {
        "@name": "DNS_UDP",
        "@location": "vsys",
        "@vsys": "vsys1",
        "protocol": {
          "udp": {
            "port": "53",
            "override": {
              "no": {}
            }
          }
        }
      },
      {
        "@name": "DNS_TCP",
        "@location": "vsys",
        "@vsys": "vsys1",
        "protocol": {
          "tcp": {
            "port": "53",
            "override": {
              "no": {}
            }
          }
        }
      }
    ]
  }
}


{"@name":"public_int","@location":"vsys","@vsys":"vsys1","ip-netmask":"172.20.241.254\/24"}