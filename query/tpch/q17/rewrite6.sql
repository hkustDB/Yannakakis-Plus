create or replace view aggView8799996717918715101 as select v1_partkey as v17, COUNT(*) as annot, v1_quantity_avg as v27 from q17_inner as q17_inner group by v1_partkey,v1_quantity_avg;
create or replace view aggJoin588386499141768497 as select l_partkey as v17, l_extendedprice as v6, annot from lineitem as lineitem, aggView8799996717918715101 where lineitem.l_partkey=aggView8799996717918715101.v17 and l_quantity>v27;
create or replace view aggView9038149790664567893 as select p_partkey as v17, COUNT(*) as annot from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX' group by p_partkey;
create or replace view aggJoin3352165141986860533 as select v6, aggJoin588386499141768497.annot * aggView9038149790664567893.annot as annot from aggJoin588386499141768497 join aggView9038149790664567893 using(v17);
select (SUM(v6*annot) / 7.0) as v29 from aggJoin3352165141986860533;
