create or replace view aggView922865157967870597 as select l_partkey as v17, SUM(l_extendedprice) as v28, l_quantity as v5 from lineitem as lineitem group by l_partkey,l_quantity;
create or replace view aggJoin5083673775524916742 as select v1_partkey as v17, v28 from q17_inner as q17_inner, aggView922865157967870597 where q17_inner.v1_partkey=aggView922865157967870597.v17 and v5>v1_quantity_avg;
create or replace view aggView8989783677004721760 as select v17, SUM(v28) as v28 from aggJoin5083673775524916742 group by v17;
select (SUM(v28) / 7.0) as v29 from part as part, aggView8989783677004721760 where part.p_partkey=aggView8989783677004721760.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';
