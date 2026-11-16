#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Keeps the front documents honest against the catalogue. Exits non-zero on any failure.

1. Every family named in docs/RANKING.md exists in cells/catalogue.json and is neither merged nor cancelled.
2. Every family that survived (green) appears in the ranking: nothing that survived is silently left out.
3. Tiers A and B hold only survived families, or open/instrument families the ranking marks as such ("open in the
   catalogue" or "instrument" on the same line or card).
4. Every relative link in README.md and docs/*.md points to an existing file.
"""
import json, os, re, sys

root = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")
cat = {r["id"]: r for r in json.load(open(os.path.join(root, "cells", "catalogue.json"), encoding="utf-8"))}
rank = open(os.path.join(root, "docs", "RANKING.md"), encoding="utf-8").read()
errors = []

named = set(re.findall(r"XC-\d\d", rank))
for i in sorted(named):
    if i not in cat:
        errors.append(f"ranking names {i}, which is not in the catalogue")
    elif cat[i]["status"] in ("merged", "cancelled"):
        errors.append(f"ranking names {i}, which is {cat[i]['status']}")

for i, r in sorted(cat.items()):
    if r["status"] == "survived" and i not in named:
        errors.append(f"{i} survived but is missing from the ranking")

tier_ab = rank.split("## Tier C")[0].split("## Tier A")[1]
blocks = re.split(r"\n(?=### |\| \d+ \|)", tier_ab)
for b in blocks:
    head = b.split("\n")[0]
    # the families being ranked: the card heading, or the "Family" cell of a table row (not ids mentioned in passing)
    ids = re.findall(r"XC-\d\d", head.split("|")[2] if head.startswith("|") else head)
    for i in ids:
        st = cat.get(i, {}).get("status")
        if st in ("open", "instrument") and not re.search(r"open in the catalogue|instrument", b, re.I):
            errors.append(f"{i} is '{st}' in the catalogue but sits in tier A/B without saying so")

docs = [os.path.join(root, "README.md"), os.path.join(root, "CONTRIBUTING.md")] + [os.path.join(root, "docs", f) for f in sorted(os.listdir(os.path.join(root, "docs")))
                                             if f.endswith(".md")]
for f in docs:
    d = os.path.dirname(f)
    for link in re.findall(r"\]\(([^)#\s]+)(?:#[^)]*)?\)", open(f, encoding="utf-8").read()):
        if re.match(r"[a-z]+:", link):
            continue
        if not os.path.exists(os.path.normpath(os.path.join(d, link))):
            errors.append(f"{os.path.relpath(f, root)}: broken link {link}")

for e in errors:
    print("FAIL", e)
print(f"{len(named)} families in the ranking, {len(errors)} problems")
sys.exit(1 if errors else 0)
