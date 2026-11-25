#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Builds the Galois page: page.html with data.json inlined (gzipped, base64), as ../galois.html.
If there is no data.json it keeps the data already in ../galois.html, so edits to the page need nothing else.
Usage: build.py"""
import base64, gzip, os, re
H = os.path.dirname(os.path.abspath(__file__)); OUT = os.path.join(H, "..", "galois.html")
page = open(os.path.join(H, "page.html")).read()
assert page.count('"/*DATA*/"') == 1
if os.path.exists(os.path.join(H, "data.json")):
    data = open(os.path.join(H, "data.json"), "rb").read()
    blob = base64.b64encode(gzip.compress(data, 9, mtime=0)).decode(); source = f"data.json, {len(data):,} bytes"
else:
    blob = re.search(r'var DATA_GZ = "([A-Za-z0-9+/=]+)";', open(OUT).read())[1]; source = "the data already in galois.html"
full = page.replace('"/*DATA*/"', '"' + blob + '"')
open(OUT, "w").write(full)
print(f"galois.html {len(full):,} bytes, from {source}")
