create or replace view aggView3078454491778497746 as select n_nationkey as v4, n_name as v43 from nation as n1;
create or replace view aggJoin8486327034885716142 as select v4, v43 from aggView3078454491778497746 where v43= 'FRANCE';
create or replace view aggView8171884648311358721 as select l_orderkey as v25, l_year as v9, l_suppkey as v1, SUM(l_extendedprice * (1 - l_discount)) as v51, COUNT(*) as annot from lineitemwithyear as lineitemwithyear where l_shipdate>=DATE '1995-01-01' and l_shipdate<=DATE '1996-12-31' group by l_orderkey,l_year,l_suppkey;
create or replace view aggView1609059685242101296 as select n_name as v47, n_nationkey as v37 from nation as n2;
create or replace view aggJoin2767608286229453824 as select v37, v47 from aggView1609059685242101296 where v47= 'GERMANY';
create or replace view semiJoinView2223780679901324844 as select s_suppkey as v1, s_nationkey as v4 from supplier AS supplier where (s_nationkey) in (select v4 from aggJoin8486327034885716142);
create or replace view semiJoinView3013108551916751042 as select v25, v9, v1, v51, annot from aggView8171884648311358721 where (v1) in (select v1 from semiJoinView2223780679901324844);
create or replace view semiJoinView6843419342907557465 as select o_orderkey as v25, o_custkey as v34 from orders AS orders where (o_orderkey) in (select v25 from semiJoinView3013108551916751042);
create or replace view semiJoinView572868257734608340 as select c_custkey as v34, c_nationkey as v37 from customer AS customer where (c_custkey) in (select v34 from semiJoinView6843419342907557465);
create or replace view semiJoinView272150838858238788 as select distinct v37, v47 from aggJoin2767608286229453824 where (v37) in (select v37 from semiJoinView572868257734608340);
create or replace view semiEnum3605253962001956219 as select distinct v34, v47 from semiJoinView272150838858238788 join semiJoinView572868257734608340 using(v37);
create or replace view semiEnum3581953715822531054 as select distinct v25, v47 from semiEnum3605253962001956219 join semiJoinView6843419342907557465 using(v34);
create or replace view semiEnum5967720730526318280 as select distinct v1, v47, v51, v9, annot from semiEnum3581953715822531054 join semiJoinView3013108551916751042 using(v25);
create or replace view semiEnum484403286537607659 as select distinct v47, v51, v9, annot, v4 from semiEnum5967720730526318280 join semiJoinView2223780679901324844 using(v1);
create or replace view semiEnum3083717252515600194 as select v43, v47, v51, v9, annot from semiEnum484403286537607659 join aggJoin8486327034885716142 using(v4);
select v43, v47, v9, SUM(v51) as v51 from semiEnum3083717252515600194 group by v43, v47, v9;

