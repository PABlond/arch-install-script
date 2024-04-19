#!/usr/bin/env python3

import psutil
import time

hdd = psutil.disk_usage('/')

print(hdd.percent)
