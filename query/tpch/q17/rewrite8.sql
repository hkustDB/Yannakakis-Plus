create or replace view aggView2397353135310954342 as select l_partkey as v17, SUM(l_extendedprice) as v28, COUNT(*) as annot, l_quantity as v5 from lineitem as lineitem group by l_partkey,l_quantity;
create or replace view aggJoin7651321745394944380 as select v1_partkey as v17, v28, annot from view1 as view1, aggView2397353135310954342 where view1.v1_partkey=aggView2397353135310954342.v17 and v5>v1_quantity_avg;
create or replace view aggView8810966127269856976 as select v17, SUM(v28) as v28, SUM(annot) as annot from aggJoin7651321745394944380 group by v17;
create or replace view aggJoin7806794646797059052 as select v28, annot from part as part, aggView8810966127269856976 where part.p_partkey=aggView8810966127269856976.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';
select (SUM(v28) / 7.0) as v29 from aggJoin7806794646797059052;
