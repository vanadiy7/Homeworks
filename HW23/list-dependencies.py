import requests
import argparse
import sys
import json

parser = argparse.ArgumentParser()
parser.add_argument ('--package',type=str)
args = parser.parse_args()

package_name = args.package

url = f'https://pypi.org/pypi/{package_name}/json'

headers = {
    'Host': 'pypi.org',
    'Accept': 'application/json',
}

response = requests.get(url, headers = headers)

if response.status_code == 200:
    data = response.json()
else:
    print('Request error')

while 'info' in data:
    package_info = data['info']
    requires_dist = package_info.get("requires_dist", [])
    for item in requires_dist:
        print(item)
    break
