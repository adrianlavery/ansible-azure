#!/usr/bin/python
# -*- coding: utf-8 -*-

# this is a windows documentation stub.  actual code lives in the .ps1
# file of the same name

DOCUMENTATION = '''
---
module: win_storage_format_new
version_added: "0.1"
short_description: "Format a New Disk"
description:
  - "Format a new disk that has not been initialised. The disk will be formatted as a basic data disk, utilising all available space and using the next available drive letter."
options:
  NewFileSystemLabel:
    description:
    - "The label on the new file system"
    default: "Data"

author: "Adrian Lavery (@alavery2004)"
'''

EXAMPLES = '''
# Run on a windows host
ansible winserver -m win_storage_format_new NewFileSystemLabel=Data
# Example from an Ansible Playbook
- action: win_template NewFileSystemLabel=Data
'''
