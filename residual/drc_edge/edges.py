#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Prints the legal intervals of each scanned probe and the rule that fires at each edge."""
import glob, os, sys
out = sys.argv[1] if len(sys.argv) > 1 else "out"
for f in sorted(glob.glob(os.path.join(out, "*.csv"))):
    rows = [l.rstrip("\n").split(";") for l in open(f)][1:]
    name = os.path.basename(f)[:-4]
    print(name)
    start = None
    for i, (v, n, rules) in enumerate(rows):
        legal = n == "0"
        if legal and start is None:
            start = v
        if (not legal or i == len(rows) - 1) and start is not None:
            end = rows[i - 1][0] if not legal else v
            print(f"   legal {start} .. {end} um")
            start = None
    seen = []
    for v, n, rules in rows:
        for r in filter(None, (x.strip() for x in rules.split("|"))):
            if r not in seen:
                seen.append(r)
                vs = [row[0] for row in rows if r in row[2]]
                print(f"   rule fires {vs[0]} .. {vs[-1]} um: {r}")
