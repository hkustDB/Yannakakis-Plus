create or replace view aggView2200216864366078495 as select n_name as v47, n_nationkey as v37 from nation as n2;
create or replace view aggJoin3866451317851295792 as select v37, v47 from aggView2200216864366078495 where v47= 'GERMANY';
create or replace view aggView7150699935750247076 as select n_nationkey as v4, n_name as v43 from nation as n1;
create or replace view aggJoin4161337053872657843 as select v4, v43 from aggView7150699935750247076 where v43= 'FRANCE';
create or replace view aggView3916676452556661797 as select l_orderkey as v25, l_year as v9, l_suppkey as v1, SUM(l_extendedprice * (1 - l_discount)) as v51, COUNT(*) as annot from lineitemwithyear as lineitemwithyear where l_shipdate>=DATE '1995-01-01' and l_shipdate<=DATE '1996-12-31' group by l_orderkey,l_year,l_suppkey;
create or replace view semiJoinView875382319364871979 as select s_suppkey as v1, s_nationkey as v4 from supplier AS supplier where (s_nationkey) in (select v4 from aggJoin4161337053872657843);
create or replace view semiJoinView2310307713422230498 as select c_custkey as v34, c_nationkey as v37 from customer AS customer where (c_nationkey) in (select v37 from aggJoin3866451317851295792);
create or replace view semiJoinView461957206479765812 as select v25, v9, v1, v51, annot from aggView3916676452556661797 where (v1) in (select v1 from semiJoinView875382319364871979);
create or replace view semiJoinView988993704346031109 as select o_orderkey as v25, o_custkey as v34 from orders AS orders where (o_custkey) in (select v34 from semiJoinView2310307713422230498);
create or replace view semiJoinView4570337076749634682 as select distinct v25, v9, v1, v51, annot from semiJoinView461957206479765812 where (v25) in (select v25 from semiJoinView988993704346031109);
create or replace view semiEnum1062862082021502249 as select distinct v51, v9, v1, v34, annot from semiJoinView4570337076749634682 join semiJoinView988993704346031109 using(v25);
create or replace view semiEnum7436818615504842693 as select distinct v37, v1, v51, v9, annot from semiEnum1062862082021502249 join semiJoinView2310307713422230498 using(v34);
create or replace view semiEnum2639086943485267827 as select distinct v37, v51, v9, annot, v4 from semiEnum7436818615504842693 join semiJoinView875382319364871979 using(v1);
create or replace view semiEnum4192496980979747304 as select distinct v51, v4, v9, annot, v47 from semiEnum2639086943485267827 join aggJoin3866451317851295792 using(v37);
create or replace view semiEnum4820840257382459657 as select v43, v47, v51, v9, annot from semiEnum4192496980979747304 join aggJoin4161337053872657843 using(v4);
select v43, v47, v9, SUM(v51) as v51 from semiEnum4820840257382459657 group by v43, v47, v9;

