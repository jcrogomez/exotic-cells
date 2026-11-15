#!/usr/bin/env python3
# shim (modo B): en 'docker run ... sh|bash -c CMD' antepone a CMD 'export SPICE_USERINIT_DIR=/hsainit;'
# y monta /hsainit con el spinit de sky130A como .spiceinit. El resto de llamadas pasa intacto.
import os, sys
a = sys.argv[1:]
if a and a[0] == "run" and "-c" in a:
    i = a.index("-c")
    a[i + 1] = "export SPICE_USERINIT_DIR=/hsainit; " + a[i + 1]
    a = ["run", "-v", "/private/tmp/claude-501/-Users-juancarlosromero-made-in-TaiJuan-projects-ZTASIC/51916679-5f4a-40b5-b300-0eeb8995ce74/scratchpad/hsa_audit/hsainit:/hsainit:ro"] + a[1:]
elif a and a[0] == "run":
    sys.stderr.write("shim: docker run sin -c, no se puede inyectar\n"); sys.exit(3)
os.execv("/usr/local/bin/docker", ["docker"] + a)
