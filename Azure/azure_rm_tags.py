#!/usr/bin/python
# -*- coding: utf-8 -*-

# this is a windows documentation stub.  actual code lives in the .ps1
# file of the same name

DOCUMENTATION = '''
---
module: azure_rm_tags
version_added: "0.1"
short_description: "Modify the tags set on a resource"
description:
  - "Create, Read, Update or Delete tags on an Azure resource"
options:
  "ResourceGroupName:
    description:
    - "The name of the resource group the resource belongs to"
    Required: "True"
  "Name:
    description:
    - "The name of the resource"
    Required: "True"
  "Tags:
    description:
    - "A list of tags in the format @(@{Name=<name1>;Value=<value1>},@{Name=<name2>;Value=<value2>}) "
    Required: "True"
  "Action:
    description:
    - "What to do with the tags. Valid Options are Create|Read|Update|Delete"
    Required: "True"
    
author: "Adrian Lavery (@alavery2004)"
'''

EXAMPLES = '''
# Run on a windows host
ansible winserver -m azure_rm_tags -ResourceGroupName "azu-rg-01" -Name "azuvm01" -Tags @(@{Name="Env";Value="Dev"},@{Name="Owner";Value="A Lavery"}) -Action "Create"
# Example from an Ansible Playbook
- action: azure_rm_tags
    ResourceGroupName="azu-rg-01"
    Name="azuvm01"
    Tags=@(@{Name="Env";Value="Dev"},@{Name="Platform";Value="SQL"})
    Action="Create"
'''