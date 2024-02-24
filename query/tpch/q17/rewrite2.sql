create or replace view aggView5039625046780774490 as select p_partkey as v17, COUNT(*) as annot from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX' group by p_partkey;
create or replace view aggJoin3135638940561101725 as select l_partkey as v17, l_quantity as v5, l_extendedprice as v6, annot from lineitem as lineitem, aggView5039625046780774490 where lineitem.l_partkey=aggView5039625046780774490.v17;
create or replace view aggView3873856775086187897 as select v17, SUM(v6 * annot) as v28, SUM(annot) as annot, v5 from aggJoin3135638940561101725 group by v17,v5;
create or replace view aggJoin7727057784394594375 as select v28, annot from q17_inner as q17_inner, aggView3873856775086187897 where q17_inner.v1_partkey=aggView3873856775086187897.v17 and v5>v1_quantity_avg;
select (SUM(v28) / 7.0) as v29 from aggJoin7727057784394594375;
