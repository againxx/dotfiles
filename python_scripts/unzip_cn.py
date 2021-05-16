#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import zipfile

print(f"Processing zip file {sys.argv[1]}")

root_dir = sys.argv[2] if len(sys.argv) > 2 else ""

file = zipfile.ZipFile(sys.argv[1], 'r')
for name in file.namelist():
    utf8_name = name.encode("cp437").decode("gbk")
    utf8_name = os.path.join(root_dir, utf8_name)
    print(f"Extracting {utf8_name}")
    path_name = os.path.dirname(utf8_name)
    if len(path_name) and not os.path.exists(path_name):
        os.makedirs(path_name)
    data = file.read(name)
    if not os.path.exists(utf8_name):
        extracted_file = open(utf8_name, 'wb')
        extracted_file.write(data)
        extracted_file.close()
file.close()
