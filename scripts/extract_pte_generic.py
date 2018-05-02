#!/usr/bin/python

# Author: Umur Darbaz
# Last Modified: Feb 8th, 2018
# Created: Feb 3rd, 2018
# Comments: Extract page permission and flag information from singleline trace
#           of page maps
import os
import sys
import re
import mmap

# This should be set if the page maps to be analyzed are obtained from docker.
CONTAINER_SPACE = 1

# Script parameters
sysArgs = 3
argCount = 6

# Page entry variables
pageSize = mmap.PAGESIZE

# Dictionaries
mapDict = {}

# Output variables
groupable = 0
exclusive = 0
totalMaps = 0
forgedMaps = 0
sharedRO = 0
sharedRW = 0
exclRO = 0
exclRW = 0
copyOnWrite = 0
hugeCount = 0
present = 0
active = 0
referenced = 0
lru = 0
groupableFlaggedShared = 0
groupableFlaggedExcl = 0

# Parsing variables
files = []

class Translation():
  def __init__(self, vpn, pfn, flags, excl, perms):
      self.vpn = vpn
      self.pfn = pfn
      self.flags = flags
      self.excl = excl
      self.perms = perms
      self.count = 1

# Is this a hugepage
def is_huge(flags):
  return ((int(flags, 0) & (1 << 17)) != 0)

# Is this page dirty
def is_dirty(flags):
  return ((int(flags, 0) & (1 << 4)) != 0)

# Identical memory page dynamically shared between one or more processes
def is_ksm(flags):
  return ((int(flags, 0) & (1 << 21)) != 0)

def is_active(flags):
  return ((int(flags, 0) & (1 << 6)) != 0)

def is_referenced(flags):
  return ((int(flags, 0) & (1 << 2)) != 0)

def is_lru(flags):
  return ((int(flags, 0) & (1 << 5)) != 0)

def process_entry(virtAddr, physAddr, flags, excl, pres, perm):
  global hugeCount
  global mapDict
  global present

  if(mapDict.has_key(virtAddr) == False):
    mapDict[virtAddr] = []
    mapDict[virtAddr].append(Translation(virtAddr, physAddr, flags, excl, perm))
  else:
    found = 0
    for translation in mapDict[virtAddr]:
      if translation.pfn == physAddr:
        translation.count += 1
        found = 1
    if found == 0:      
      mapDict[virtAddr].append(Translation(virtAddr, physAddr, flags, excl, perm))

  # Sanity check to see if there are any hugepages
  if(is_huge(flags)):
     hugeCount += 1

  if pres:
    present += 1

# Used to determine images, types to iterate over
def process_sys_args():
  global files
  for i in xrange(1,len(sys.argv)):
    files.append(sys.argv[i])

# Make it bun them
def reset_data():
  global mapDict
  global groupable
  global exclusive
  global sharedRO
  global sharedRW
  global exclRO
  global exclRW
  global copyOnWrite
  global present
  global active
  global referenced
  global lru
  global groupableFlaggedShared
  global groupableFlaggedExcl

  mapDict = {}
  groupable = 0
  exclusive = 0
  sharedRO = 0
  sharedRW = 0
  exclRO = 0
  exclRW = 0
  copyOnWrite = 0
  present = 0
  active = 0
  referenced = 0
  lru = 0
  groupableFlaggedShared = 0
  groupableFlaggedExcl = 0

# Get system arguments
process_sys_args()
reset_data()

# Go over all page map logs
for fileName in files:
    pteLog = open(fileName, "r")
    for line in pteLog:
      args = []
      words = re.split(', ', line)
      for idx in xrange(0,argCount):
        args.append(re.split(' ', words[idx])[1])

      # Process the page map entry, insert keys and data
      process_entry(args[0], args[1], args[2], args[3], args[4], args[5])

for key in mapDict:
  for translation in mapDict[key]:
    if translation.count == 1:
      exclusive += 1
      forgedMaps += 1

      if translation.perms.find("r-") != -1:
        exclRO += translation.count
      elif translation.perms.find("rw") != -1:
        exclRW += translation.count
      
    else:
      groupable += translation.count
      forgedMaps += 1
      copyOnWrite += translation.count - 1

      if translation.excl == "0x0":
        groupableFlaggedShared += translation.count
      else:
        groupableFlaggedExcl += translation.count
      
      if translation.perms.find("r-") != -1:
        sharedRO += translation.count
      elif translation.perms.find("rw") != -1:
        sharedRW += translation.count

    active += is_active(translation.flags)*translation.count
    referenced += is_referenced(translation.flags)*translation.count
    lru += is_lru(translation.flags)*translation.count

totalMaps = exclusive + groupable
    
print "Total Mappings: {}, Forged Mappings: {}".format(totalMaps, forgedMaps)
print "Groupable: {}, Exlusive: {}".format(groupable, exclusive)
print "Groupable Breakdown: RO: {}, R/W: {}".format(sharedRO, sharedRW)
print "Exclusive Breakdown: RO: {}, R/W: {}".format(exclRO, exclRW)
print "Hugepages: {}, Estimated CoW: {}".format(hugeCount, copyOnWrite)
print "Present: {}, Active: {}, Referenced: {}, LRU: {}".format(present, active, referenced, lru)
print "Groupable Flagged-Shared: {}, Groupable Flagged-Exclusive: {}".format(groupableFlaggedShared, groupableFlaggedExcl)
