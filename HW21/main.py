#!/usr/bin/python3
import argparse
from ipaddress import IPv4Address, IPv4Network

def calculate_subnet(ip, cidr_mask):
    network = IPv4Network(ip + cidr_mask, strict=False)
    subnet_address = str(network.network_address)
    subnet_mask = str(network.netmask)
    first_host = str(network.network_address + 1)
    last_host = str(network.broadcast_address - 1)
    broadcast_address = str(network.broadcast_address)
    subnet_class = get_subnet_class(network)

    return subnet_address, subnet_mask, first_host, last_host, broadcast_address, subnet_class

def get_subnet_class(network):

    first_octet = int(network.network_address.exploded.split('.')[0])

    if 1 <= first_octet <=128:
        return 'A'
    elif 128 <= first_octet <= 191:
        return 'B'
    elif 192 <= first_octet <= 223:
        return 'C'
    elif 224 <= first_octet <= 239:
        return 'D'
    elif 240 <= first_octet <= 255:
        return 'E'

parser = argparse.ArgumentParser(description='Subnet Calculator')
parser.add_argument('--ip', help='IP address')
parser.add_argument('--cidr_mask', help='CIDR mask')
args = parser.parse_args()

ip = IPv4Address(args.ip)
cidr_mask = args.cidr_mask

subnet_address, subnet_mask, first_host, last_host, broadcast_address, subnet_class = calculate_subnet(str(ip), cidr_mask)

print ("subnet_address: " + subnet_address)
print("subnet_mask: " + subnet_mask)
print("IP first_host: " + first_host)
print("IP last_host: " + last_host)
print("broadcast_address: " + broadcast_address)
print("subnet_class: " + subnet_class)
