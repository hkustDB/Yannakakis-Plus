create or replace view semiJoinView1699040062225508006 as select src as v4, dst as v2 from Graph AS g3 where (dst, src) in (select (src, dst) from Graph AS g2);
create or replace view semiJoinView8242147546296719500 as select src as v2, dst as v8 from Graph AS g4 where (src, dst) in (select (dst, src) from Graph AS g1);
create or replace view semiJoinView4973807297564594204 as select v2, v8 from semiJoinView8242147546296719500 where (v2) in (select (v2) from semiJoinView1699040062225508006);
create or replace view semiEnum4102928358756446601 as select v2, v8, v4 from semiJoinView4973807297564594204 join semiJoinView1699040062225508006 using(v2);
create or replace view semiEnum3944055752489836866 as select v8, v4, v2 from semiEnum4102928358756446601, Graph as g1 where g1.dst=semiEnum4102928358756446601.v2 and g1.src=semiEnum4102928358756446601.v8;
create or replace view semiEnum8636734408597866027 as select v8, v4, v2 from semiEnum3944055752489836866, Graph as g2 where g2.src=semiEnum3944055752489836866.v2 and g2.dst=semiEnum3944055752489836866.v4;
select v8, v2, v2, v4, v4, v2, v2, v8 from semiEnum8636734408597866027;
