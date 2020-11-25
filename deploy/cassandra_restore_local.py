#!/usr/bin/env python3

# This program will copy the snapshots to cassandra data directory
# and do nodetool refresh for keyspace/table combo.
# Required tools : nodetool
# This program will only work in linux, as it's utilizing 'cp' for copying as shutil and copy_tree
# are not handling hardlink, existing directory combo.
#
# Author Rajesh Rajendran <rjshrjndrn@gmail.com>

import os
import shutil
from argparse import ArgumentParser
from collections import defaultdict
from subprocess import STDOUT, call
import concurrent.futures

parser = ArgumentParser(description="Restore cassandra snapshot")
parser.add_argument("-d", "--datadirectory", metavar="datadir",  default='/var/lib/cassandra/data',
                    help="Path to cassadandra keyspaces. Default /var/lib/cassadra/data")
parser.add_argument("-w", "--workers", metavar="workers",
                    default=os.cpu_count(), help="Number of workers to use. Default same as cpu cores {}".format(os.cpu_count()))
parser.add_argument("--snapshotdir", default="cassandra_backup", metavar="< Default: cassandra_backup >", help="snapshot directory name or path")
args = parser.parse_args()

# copy function
def customCopy(root, root_target_dir):
    print("copying {} to {}".format(root, root_target_dir))
    # Shuti and cp_tree are not good enough
    call(["cp -arl " + root + " " + root_target_dir],shell=True, stderr=STDOUT)

# ks_tb_pair = {ks_name: ['table1', 'table2']}
ks_tb_pair = defaultdict(list)

def create_ks_tb_pair(path):
    # containes parsed path
    # backupdir/sunbirdplugin/announcement-6bc5074070ef11e995fbf564f8591b58
    # [backupdir,sunbirdplugin,announcement-6bc5074070ef11e995fbf564f8591b58]
    parsed_data = path.split('/')
    # splitting parsed_data[-1] with '-' because we don't need UUID
    ks_tb_pair[parsed_data[-2]].append(parsed_data[-1].split('-')[0])
    # print(ks_tb_pair)
    # Copy content to datadirectory
    customCopy(path+'/*', args.datadirectory+os.sep+parsed_data[-2]+os.sep+parsed_data[-1].split("-")[0]+"-*")

# Traverse through backup dir and create keyspace table pair
# Unix autocompletion for directory will append '/', which will break restore process
snap_dir = args.snapshotdir.rstrip('/')
root_levels = snap_dir.count(os.sep)
for root, dirs, files in os.walk(snap_dir):
    # our tables will be under /keyspace/table
    if root.count(os.sep) == root_levels + 2:
        # output will be like
        # backupdir/sunbirdplugin/announcement-6bc5074070ef11e995fbf564f8591b58
        # backupdir/sunbirdplugin/groupmember-8c7eb6c070ef11e9858587f867de3ce2
        # print(root)
        create_ks_tb_pair(root)


def nodetoolRefresh(ks, table):
    print("\n======= Refreshing {}/{} =======".format(ks,table))
    call(["nodetool", "refresh", ks, table], stderr=STDOUT)

futures = []
# nodetool refresh
# Running parellel node tool refresh
with concurrent.futures.ThreadPoolExecutor(max_workers=args.workers) as executor:
    for ks, tables in ks_tb_pair.items():
        for table in tables:
            tmp_arr = [ks, table]
            futures.append( executor.submit( lambda p: nodetoolRefresh(*p), tmp_arr))
# Checking status of the copy operation
for future in concurrent.futures.as_completed(futures):
    try:
        print("Task completed. Result: {}".format(future.result()))
    except Exception as e:
        print(e)
