SELECT r.a as a, t.d as d, sum(e)
FROM R AS r, S AS s, T AS t
WHERE r.b = s.b AND s.c = t.c
Group by r.a, t.d