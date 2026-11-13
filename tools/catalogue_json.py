#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Writes cells/catalogue.json from the catalogue table in README.md, so that the catalogue can be read by programs.
The Markdown table stays the single source; run this after editing it. Exits non-zero if the JSON on disk is stale (--check)."""
import json, os, re, sys
root = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")
STATUS = {"🟢": "survived", "🟡": "open", "🔵": "instrument", "⚪": "merged", "🔴": "cancelled"}
rows = []
for line in open(os.path.join(root, "README.md"), encoding="utf-8"):
    c = [x.strip() for x in line.strip().strip("|").split("|")]
    if len(c) == 9 and c[1].startswith("XC-"):
        m = re.fullmatch(r"\[(.+)\]\((.+)\)", c[2])
        family, plan = (m.group(1), m.group(2)) if m else (c[2], None)
        assert c[0] in STATUS, f"{c[1]}: unknown status mark {c[0]!r}"
        if plan:
            assert os.path.exists(os.path.join(root, plan)), f"{c[1]}: missing {plan}"
        rows.append(dict(id=c[1], status=STATUS[c[0]], family=family, plan=plan, mechanism=c[3], engine=c[4],
                         vehicle=c[5], usefulness=c[6] or None, information=c[7] or None, state=c[8]))
ids = [r["id"] for r in rows]
assert ids == [f"XC-{i:02d}" for i in range(1, len(ids) + 1)], "identifiers must be consecutive and never reused"
text = json.dumps(rows, indent=1, ensure_ascii=False) + "\n"
path = os.path.join(root, "cells", "catalogue.json")
if "--check" in sys.argv:
    ok = os.path.exists(path) and open(path, encoding="utf-8").read() == text
    sys.exit(0 if ok else "cells/catalogue.json is stale: run tools/catalogue_json.py")
open(path, "w", encoding="utf-8").write(text)
print(f"{len(rows)} families written")
