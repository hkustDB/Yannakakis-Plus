SELECT g1.src AS src, g1.dst AS via1, g3.src AS via2, g3.dst AS via3, g4.dst as dst
FROM Graph AS g1, Graph AS g2, Graph AS g3, Graph as g4
WHERE g1.dst = g2.src AND g2.dst = g3.src AND g3.dst = g4.src AND g1.src < g4.dst