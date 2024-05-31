create or replace view aggView8204939912847053777 as select p_partkey as v17 from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggJoin7077228100125439839 as select l_partkey as v17, l_quantity as v5, l_extendedprice as v6 from lineitem as lineitem, aggView8204939912847053777 where lineitem.l_partkey=aggView8204939912847053777.v17;
create or replace view aggView3354043911560479951 as select v1_partkey as v17, v1_quantity_avg as v27 from q17_inner as q17_inner;
create or replace view aggJoin5893127991749887181 as select v5, v6, v27 from aggJoin7077228100125439839 join aggView3354043911560479951 using(v17) where v5 > v27;
create or replace view aggView5426999707074640142 as select v6, COUNT(*) as annot from aggJoin5893127991749887181 group by v6;
select (SUM((v6)* annot) / 7.0) as v29 from aggView5426999707074640142;
