create or replace view aggView5039625046780774490 as select p_partkey as v17 from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggJoin3135638940561101725 as select l_partkey as v17, l_quantity as v5, l_extendedprice as v6 from lineitem as lineitem, aggView5039625046780774490 where lineitem.l_partkey=aggView5039625046780774490.v17;
create or replace view aggView3873856775086187897 as select v17, SUM(v6) as v28, v5 from aggJoin3135638940561101725 group by v17,v5;
create or replace view aggJoin7727057784394594375 as select v28 from q17_inner as q17_inner, aggView3873856775086187897 where q17_inner.v1_partkey=aggView3873856775086187897.v17 and v5>v1_quantity_avg;
select (SUM(v28) / 7.0) as v29 from aggJoin7727057784394594375;
