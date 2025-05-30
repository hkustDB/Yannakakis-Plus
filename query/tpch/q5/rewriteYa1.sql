create or replace view semiUp9114672351580514276 as select l_orderkey as v18, l_suppkey as v20, l_extendedprice as v23, l_discount as v24 from lineitem AS lineitem where (l_suppkey) in (select s_suppkey from supplier AS supplier);
create or replace view semiUp5596056941933172615 as select n_nationkey as v4, n_name as v42, n_regionkey as v43 from nation AS nation where (n_regionkey) in (select r_regionkey from region AS region where r_name= 'ASIA');
create or replace view semiUp654727505751686521 as select c_custkey as v1, c_nationkey as v4 from customer AS customer where (c_nationkey) in (select v4 from semiUp5596056941933172615);
create or replace view semiUp2277543237332152416 as select o_orderkey as v18, o_custkey as v1 from orders AS orders where (o_custkey) in (select v1 from semiUp654727505751686521) and o_orderdate>=DATE '1994-01-01' and o_orderdate<DATE '1995-01-01';
create or replace view semiUp4091479901969541815 as select v18, v20, v23, v24 from semiUp9114672351580514276 where (v18) in (select v18 from semiUp2277543237332152416);
create or replace view semiDown4386295811138608867 as select s_suppkey as v20, s_nationkey as v50 from supplier AS supplier where (s_suppkey) in (select v20 from semiUp4091479901969541815);
create or replace view semiDown3517920388236768749 as select v18, v1 from semiUp2277543237332152416 where (v18) in (select v18 from semiUp4091479901969541815);
create or replace view semiDown2880512851140836932 as select v1, v4 from semiUp654727505751686521 where (v1) in (select v1 from semiDown3517920388236768749);
create or replace view semiDown8636728038207974621 as select v4, v42, v43 from semiUp5596056941933172615 where (v4) in (select v4 from semiDown2880512851140836932);
create or replace view semiDown7520564571830600337 as select r_regionkey as v43 from region AS region where (r_regionkey) in (select v43 from semiDown8636728038207974621) and r_name= 'ASIA';
create or replace view aggView2746201720742989737 as select v43 from semiDown7520564571830600337;
create or replace view aggJoin7629086208372373338 as select v4, v42 from semiDown8636728038207974621 join aggView2746201720742989737 using(v43);
create or replace view aggView7572184181759174800 as select v4, v42, COUNT(*) as annot from aggJoin7629086208372373338 group by v4,v42;
create or replace view aggJoin6764242224913074440 as select v1, v4, v42, annot from semiDown2880512851140836932 join aggView7572184181759174800 using(v4);
create or replace view aggView8553809748908849611 as select v1, v4, v42, SUM(annot) as annot from aggJoin6764242224913074440 group by v1,v4,v42;
create or replace view aggJoin6491828844895898347 as select v18, v4, v42, annot from semiDown3517920388236768749 join aggView8553809748908849611 using(v1);
create or replace view aggView5936193247586128063 as select v20, v50 from semiDown4386295811138608867;
create or replace view aggJoin6355808351409440093 as select v18, v23, v24, v50 from semiUp4091479901969541815 join aggView5936193247586128063 using(v20);
create or replace view aggView7803526731209402752 as select v18, v4, v42, SUM(annot) as annot from aggJoin6491828844895898347 group by v18,v4,v42;
create or replace view aggJoin8825927035375078032 as select v23, v24, v42, annot from aggJoin6355808351409440093 join aggView7803526731209402752 using(v18) where v4 = v50;
select v42, SUM((v23 * (1 - v24))*annot) as v49 from aggJoin8825927035375078032 group by v42;

