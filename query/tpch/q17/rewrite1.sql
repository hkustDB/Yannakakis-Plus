create or replace view aggView6759948505664611347 as select p_partkey as v17 from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggJoin4705921909490000698 as select v1_partkey as v17, v1_quantity_avg as v27 from q17_inner as q17_inner, aggView6759948505664611347 where q17_inner.v1_partkey=aggView6759948505664611347.v17;
create or replace view aggView8600763006573027466 as select v17, COUNT(*) as annot, v27 from aggJoin4705921909490000698 group by v17,v27;
create or replace view aggJoin1165567198038974261 as select l_quantity as v5, l_extendedprice as v6, v27, annot from lineitem as lineitem, aggView8600763006573027466 where lineitem.l_partkey=aggView8600763006573027466.v17 and l_quantity>v27;
create or replace view aggView1338083374709425392 as select v6, SUM(annot) as annot from aggJoin1165567198038974261;
select (SUM((v6)* annot) / 7.0) as v29 from aggView1338083374709425392;
