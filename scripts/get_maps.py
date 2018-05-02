#!/usr/bin/python

# Original Author: Jeff Li
# Date: Nov 8th, 2014
# Modification: Umur Darbaz
# Date: Dec 3rd, 2017
# Comments: Automated the procedure so that VPNs are read from /proc/PID/maps
#			and a PFN is outputted for all of them.

import os
import sys
import binascii
import struct
import re
import mmap

basePath = "/proc/"
pageSize = mmap.PAGESIZE
bytesPerEntry = 8
hexBase = 16

# This function will read
# the next 8 characters from any given file.
def read_entry(path, offset, size=8):
  with open(path, 'r') as f:
    f.seek(offset, 0)
    nextByte = f.read(size)
    if len(nextByte) < 8:
    	return -1
    return struct.unpack('Q', nextByte)[0]

# Read /proc/$PID/pagemap
def get_pagemap_entry(pid, addr):
  maps_path = "/proc/{0}/pagemap".format(pid)
  if not os.path.isfile(maps_path):
    print "Process {0} doesn't exist.".format(pid)
    return
  offset  = (addr / pageSize) * bytesPerEntry

  return read_entry(maps_path, offset)

def get_pfn(entry):
  return entry & 0x7FFFFFFFFFFFFF

def is_present(entry):
  return ((entry & (1 << 63)) != 0)

def is_exclusive(entry):
  return ((entry & (1 << 56)) != 0)

# Read /proc/kpageflags
def get_page_flags(pfn):
  file_path = "/proc/kpageflags"
  offset = pfn * bytesPerEntry
  return read_entry(file_path, offset)

# Wrapper to get page frame number
def read_pfn_entry(pid, addr, perm):
  entry = get_pagemap_entry(pid, addr)
  pfn = get_pfn(entry)
  if(is_present(entry)):
  	print "VirtualAddress: {}, PFN: {}, Flags: {}, Excl: {}, Pres: {}, Perm: {} ".format(hex(addr), hex(pfn), hex(get_page_flags(pfn)), hex(is_exclusive(entry)), hex(is_present(entry)), perm)

if len(sys.argv) < 2:
	print("Insufficient arguments. Please provide a PID.")
	exit(1)

pid = sys.argv[1]
basePath = basePath + pid + "/"
virtualMaps = open(basePath + "maps", "r")

for line in virtualMaps:
  sections = re.split(' ', line)
  addresses = re.split('-', sections[0])
  permissions = sections[1]
  base = long(addresses[0], hexBase)
  end = long(addresses[1], hexBase)
  numPagesInRange = (end - base)/pageSize
  for offset in xrange(numPagesInRange):
		read_pfn_entry(pid, (base + offset*pageSize), permissions)
