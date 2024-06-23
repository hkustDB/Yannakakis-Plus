create or replace view aggView4612774035206084023 as select p_partkey as v17 from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggJoin5360146984335832741 as select v1_partkey as v17, v1_quantity_avg as v27 from q17_inner as q17_inner, aggView4612774035206084023 where q17_inner.v1_partkey=aggView4612774035206084023.v17;
create or replace view aggView691016993754081989 as select v17, COUNT(*) as annot, v27 from aggJoin5360146984335832741 group by v17,v27;
create or replace view aggJoin3223813982711027773 as select l_quantity as v5, l_extendedprice as v6, v27, annot from lineitem as lineitem, aggView691016993754081989 where lineitem.l_partkey=aggView691016993754081989.v17 and l_quantity>v27;
create or replace view aggView3762594601678086692 as select v6, SUM(annot) as annot from aggJoin3223813982711027773 group by v6;
create or replace view res as select (SUM((v6)* annot) / 7.0) as v29 from aggView3762594601678086692;
select sum(v29) from res;