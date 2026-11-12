#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Counts violations per rule in the .lyrdb reports of a probe and prints them next to Magic's verdict."""
import glob, os, re, sys
out, probe = sys.argv[1], sys.argv[2]
magic = {l.split(";")[0]: l.rstrip("\n").split(";") for l in open(os.path.join(out, probe + ".magic.csv"))}
for f in sorted(glob.glob(os.path.join(out, probe + "_*.lyrdb"))):
    v = re.search(r"_(\d+p\d+)\.lyrdb$", f).group(1).replace("p", ".")
    cats = {}
    # plain text search: the report is small, and it avoids depending on an XML library
    for item in re.findall(r"<item>(.*?)</item>", open(f).read(), re.S):
        c = re.search(r"<category>(.*?)</category>", item, re.S).group(1).strip().strip("'")
        cats[c] = cats.get(c, 0) + 1
    m = magic[v]
    print(f"{probe} v={v}  magic: {'clean' if m[1]=='0' else m[2]}  ||  klayout: {'clean' if not cats else cats}")
