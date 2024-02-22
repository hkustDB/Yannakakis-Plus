create or replace view aggView4867223456507550469 as select v1_partkey as v17, COUNT(*) as annot, v1_quantity_avg as v27 from view1 as view1 group by v1_partkey,v1_quantity_avg;
create or replace view aggJoin5012213775296885034 as select l_partkey as v17, l_extendedprice as v6, annot from lineitem as lineitem, aggView4867223456507550469 where lineitem.l_partkey=aggView4867223456507550469.v17 and l_quantity>v27;
create or replace view aggView6988358879724626164 as select p_partkey as v17, COUNT(*) as annot from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX' group by p_partkey;
create or replace view aggJoin3589923245564316882 as select v6, aggJoin5012213775296885034.annot * aggView6988358879724626164.annot as annot from aggJoin5012213775296885034 join aggView6988358879724626164 using(v17);
select (SUM(v6*annot) / 7.0) as v29 from aggJoin3589923245564316882;
