create or replace view aggView3102501935800131681 as select p_partkey as v17 from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggJoin6499964280972038158 as select l_partkey as v17, l_quantity as v5, l_extendedprice as v6 from lineitem as lineitem, aggView3102501935800131681 where lineitem.l_partkey=aggView3102501935800131681.v17;
create or replace view aggView2331110597672894250 as select v1_partkey as v17, v1_quantity_avg as v27 from q17_inner as q17_inner;
create or replace view aggJoin8353316104166717750 as select v5, v6, v27 from aggJoin6499964280972038158 join aggView2331110597672894250 using(v17) where v5 > v27;
create or replace view aggView3148056002027572405 as select v6, COUNT(*) as annot from aggJoin8353316104166717750 group by v6;
select SUM((v6)* annot) / 7.0 as v29 from aggView3148056002027572405;
