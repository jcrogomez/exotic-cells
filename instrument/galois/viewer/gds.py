# SPDX-License-Identifier: Apache-2.0
"""Minimal GDSII stream reader (no dependencies): cells with their boundaries, paths, text labels and references.
read(path) -> (dbu_in_um, {cell: {"b": [(layer, datatype, [(x, y), ...])], "t": [(layer, texttype, x, y, string)],
                                  "r": [(cell, x, y, mirror_x, angle_deg, cols, rows, dx, dy)]}})
Paths are turned into boundaries (Manhattan segments only, flush or half-width extended ends). Coordinates are in database units."""
import struct

def _real8(b):
    s = b[0] & 0x80; e = (b[0] & 0x7F) - 64; m = int.from_bytes(b[1:8], "big") / 2 ** 56
    return (-1 if s else 1) * m * 16 ** e

def read(path):
    d = open(path, "rb").read(); i = 0; cells = {}; cur = None; el = None; dbu = None
    while i < len(d):
        n, rt, dt = struct.unpack(">HBB", d[i:i + 4]); body = d[i + 4:i + n]; i += n
        if rt == 0x03: dbu = _real8(body[8:16]) * 1e6
        elif rt == 0x06: cur = cells.setdefault(body.rstrip(b"\0").decode(), {"b": [], "t": [], "r": []})
        elif rt in (0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x2D): el = {"k": rt, "w": 0, "pt": 0, "mir": False, "ang": 0.0}
        elif rt == 0x0D: el["l"] = struct.unpack(">h", body)[0]
        elif rt in (0x0E, 0x16, 0x2E): el["d"] = struct.unpack(">h", body)[0]
        elif rt == 0x0F: el["w"] = struct.unpack(">i", body)[0]
        elif rt == 0x21: el["pt"] = struct.unpack(">h", body)[0]
        elif rt == 0x10: el["xy"] = [struct.unpack(">ii", body[k:k + 8]) for k in range(0, len(body), 8)]
        elif rt == 0x12: el["sn"] = body.rstrip(b"\0").decode()
        elif rt == 0x13: el["cr"] = struct.unpack(">hh", body)
        elif rt == 0x19: el["s"] = body.rstrip(b"\0").decode()
        elif rt == 0x1A: el["mir"] = bool(struct.unpack(">H", body)[0] & 0x8000)
        elif rt == 0x1C: el["ang"] = _real8(body)
        elif rt == 0x11 and el is not None:
            k = el["k"]
            if k == 0x08: cur["b"].append((el["l"], el["d"], el["xy"][:-1]))
            elif k == 0x2D: cur["b"].append((el["l"], el["d"], el["xy"][:-1]))
            elif k == 0x09:
                h = el["w"] // 2; ext = h if el["pt"] == 2 else 0; p = el["xy"]
                for a, b in zip(p, p[1:]):
                    x0, x1 = sorted((a[0], b[0])); y0, y1 = sorted((a[1], b[1]))
                    if a[1] == b[1]: x0 -= ext; x1 += ext; y0 -= h; y1 += h
                    else: y0 -= ext; y1 += ext; x0 -= h; x1 += h
                    cur["b"].append((el["l"], el["d"], [(x0, y0), (x1, y0), (x1, y1), (x0, y1)]))
            elif k == 0x0C: cur["t"].append((el["l"], el["d"], el["xy"][0][0], el["xy"][0][1], el.get("s", "")))
            elif k == 0x0A: cur["r"].append((el["sn"], el["xy"][0][0], el["xy"][0][1], el["mir"], el["ang"], 1, 1, 0, 0))
            elif k == 0x0B:
                c, r = el["cr"]; o, pc, pr = el["xy"]
                cur["r"].append((el["sn"], o[0], o[1], el["mir"], el["ang"], c, r, (pc[0] - o[0]) // c, (pr[1] - o[1]) // r))
            el = None
    return dbu, cells

def tr(x, y, ox, oy, mir, ang):
    if mir: y = -y
    a = int(round(ang)) % 360
    if a == 90: x, y = -y, x
    elif a == 180: x, y = -x, -y
    elif a == 270: x, y = y, -x
    return x + ox, y + oy
