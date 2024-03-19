create or replace view semiJoinView8998466328601451851 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select src from Graph AS g4) and src<dst;
create or replace view semiJoinView6979966114369416892 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select dst from Graph AS g1) and src<dst;
create or replace view semiJoinView2755192065943182631 as select v2, v4 from semiJoinView6979966114369416892 where (v4) in (select v4 from semiJoinView8998466328601451851);
create or replace view semiEnum2930396651168820988 as select v6, v2, v4 from semiJoinView2755192065943182631 join semiJoinView8998466328601451851 using(v4);
create or replace view semiEnum4030613620075499414 as select v2, v4, src as v1, v6 from semiEnum2930396651168820988, Graph as g1 where g1.dst=semiEnum2930396651168820988.v2;
create or replace view semiEnum5019398371802473950 as select dst as v8, v2, v4, v1, v6 from semiEnum4030613620075499414, Graph as g4 where g4.src=semiEnum4030613620075499414.v6;
select sum(v1+v2+v4+v6+v8) from semiEnum5019398371802473950;
