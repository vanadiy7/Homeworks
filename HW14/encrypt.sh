#!/bin/bash

openssl pkeyutl -encrypt -pubin -inkey public.pem -out test.txt.enc
cat test.txt.enc
