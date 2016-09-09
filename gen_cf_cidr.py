#!/usr/bin/env python

import requests, json

d = requests.get('https://ip-ranges.amazonaws.com/ip-ranges.json').text
l = json.loads(d)
for ip_range in [x['ip_prefix'] for x in l['prefixes'] if x['service']=='CLOUDFRONT' ]:
        print ip_range
