"""Filas del motor del autor para cotejar con el verificador las diferencias que deciden D5–D8 (ver INFORME). Uso: corre_cotejo.py <parte 0-3>"""
import sys, warnings; warnings.filterwarnings("ignore")
import motor3 as M
partes = [
    [("W1", "C3b", "A2", "E1"), ("W1", "C3b", "A2", "E2"), ("W1", "C3b", "A2", "E4")],
    [("W1", "C3b", "S10", "E2"), ("W1", "C3b", "S10", "E4"), ("W1", "C3b", "S10", "E1")],
    [("W1", "C3b", "X", "E1"), ("W1", "C3b", "A", "E1"), ("W1", "C3b", "X", "E4"), ("W1", "C3b", "A", "E4")],
    [("W0", "C1", "A", "E1"), ("W0", "C1", "X", "E1"), ("W0", "C1", "A2", "E1"), ("W2", "C3b", "A2", "E2"), ("W2", "C3b", "A2", "E4")],
]
i = int(sys.argv[1])
M.correr(partes[i], 300, 5000, 2000, "cotejo%d" % i)
