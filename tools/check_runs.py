#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Judges the committed runs. Exits non-zero if any simulation log or generated deck shows a known failure mode.

Checks (each one exists because the failure happened to us):
  1. ngspice logs: errors, failed measurements, unknown parameters or subcircuits.
  2. Generated decks: a subcircuit instance carrying mult= (ngspice ignores it for the PDK devices; the multiplier is m=).
  3. Decks that claim a long high-threshold precharge must instantiate it.
Folders named run<N>_* are kept failed runs and are skipped.
"""
import os, re, sys
root = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")
BAD_LOG = re.compile(r"(^|\s)(Error|error:)|out of interval|unknown subckt|Too (many|few) parameters|not found|"
                     r"singular matrix|Timestep too small|no such vector", re.I)
ALLOW = re.compile(r"Reference value|Note:|rndseed|No errors found|no such parameter ueff|ueff\]|&ue: no such", re.I)
# Logs with a known, documented defect: path -> reason. Listed in the output so that they are never silent.
KNOWN = {}
kf = os.path.join(root, "tools", "known_issues.txt")
if os.path.exists(kf):
    for line in open(kf):
        if line.strip() and not line.startswith("#"):
            path, reason = line.split("|", 1)
            KNOWN[path.strip()] = reason.strip()
problems = []
for d, dirs, files in os.walk(root):
    dirs[:] = [x for x in dirs if not re.match(r"run\d+_", x) and x not in (".git", "out", "cases")]
    for f in files:
        p = os.path.join(d, f)
        rel = os.path.relpath(p, root)
        if rel in KNOWN:
            print(f"known issue, skipped: {rel}: {KNOWN[rel]}")
            continue
        if f.endswith(".log") and "experiments" in rel:
            for n, line in enumerate(open(p, errors="replace"), 1):
                if BAD_LOG.search(line) and not ALLOW.search(line):
                    problems.append(f"{rel}:{n}: {line.strip()[:120]}")
        if f.endswith(".sp"):
            text = open(p).read()
            for n, line in enumerate(text.splitlines(), 1):
                if line[:1] in "Xx" and re.search(r"\bmult\s*=\s*(?!1\b)", line):
                    problems.append(f"{rel}:{n}: mult= on an instance is ignored by ngspice; use m=")
            if re.search(r"high-threshold precharge|hvt precharge", text, re.I) and "_hvt" not in text:
                problems.append(f"{rel}: claims a high-threshold precharge but has none")
for x in problems:
    print(x)
print(f"check_runs: {len(problems)} problem(s)")
sys.exit(bool(problems))
