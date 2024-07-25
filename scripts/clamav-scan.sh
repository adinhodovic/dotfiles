#!/bin/bash

# Update ClamAV database
freshclam

# Run ClamAV scan on /
clamscan -i -l /var/log/clamav/scan.log --recursive / >/var/log/clamav/summary.txt
