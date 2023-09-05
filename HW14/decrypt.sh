#!/bin/bash

openssl pkeyutl -decrypt -inkey private.pem -in test.txt.enc -out test_dec.txt
cat test_dec.txt
