#!/usr/bin/env python3
import smtplib
from email.message import EmailMessage
import getpass
from smtplib import SMTP
import argparse

parser = argparse.ArgumentParser()
parser.add_argument ('--From', type = str)
parser.add_argument('--To', type = str)
args = parser.parse_args()

sender = args.From
receiver = args.To

def send_mail(message,sender,receiver):

    login = input("Username: ")
    password = getpass.getpass("Password: ")
    
    
    server = smtplib.SMTP("smtp.gmail.com", 587)
    server.starttls()

    try:
        server.login(login, password)
        server.sendmail(sender,receiver,message)
        return "sent!"
    except Exception:
      return("Check your login or password")
    


def main():
    message = input("Input message: \n")
    print(send_mail(message,sender,receiver))

if __name__ == "__main__":
    main()
