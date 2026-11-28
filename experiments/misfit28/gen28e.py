"""MISFIT-28, enmienda 1: los decks de rango bajo de gen28.lista() (grupos a, lento, mm) con paso maximo <= 0,1 us, en e1/.
Mas el control de convergencia e1/fino/: 316 pA, las cuatro esquinas, paso maximo 0,03 us. gen28.py no se toca."""
import os, gen28 as g
PASO = 1e-7; FINO = 3e-8; _nombre = g.nombre


def nombre_e(grp, c, t, rng, k, i, kw): return _nombre(grp, c, t, rng, k, i, kw).replace(g.H + os.sep, os.path.join(g.H, "e1") + os.sep, 1)


def es_e(grp, rng): return rng == "bajo" and grp in ("a", "lento", "mm")


def con_paso(s, paso):
    L = s.splitlines(); j = next(j for j, l in enumerate(L) if l.startswith("tran ")); f = L[j].split(); assert len(f) == 5 and f[3] == "0", L[j]
    f[4] = f"{min(float(f[4]), paso):.3e}"; L[j] = " ".join(f); return "\n".join(L) + "\n"


def lista_e(): return [x for x in g.lista() if es_e(x[0], x[3])]


def lista_fino(): return [("fino", c, t, "bajo", "oos", 3.1623e-10, {}) for c, t in g.G.CORN]


if __name__ == "__main__":
    n = {}
    for x, paso in [(x, PASO) for x in lista_e()] + [(x, FINO) for x in lista_fino()]:
        grp, c, t, rng, k, i, kw = x; d = nombre_e(*x); os.makedirs(d, exist_ok=True)
        open(os.path.join(d, "lec.sp"), "w").write(con_paso(g.deck(g.PEX, g.EXT, c, t, rng, k, i, **kw), paso)); n[grp] = n.get(grp, 0) + 1
    print("decks:", n, sum(n.values()))
