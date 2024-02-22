create or replace view aggView2354772678744912137 as select l_partkey as v17, SUM(l_extendedprice) as v28, COUNT(*) as annot, l_quantity as v5 from lineitem as lineitem group by l_partkey,l_quantity;
create or replace view aggJoin6666861038331899805 as select v1_partkey as v17, v28, annot from view1 as view1, aggView2354772678744912137 where view1.v1_partkey=aggView2354772678744912137.v17 and v5>v1_quantity_avg;
create or replace view aggView5964323102213219661 as select p_partkey as v17, COUNT(*) as annot from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX' group by p_partkey;
create or replace view aggJoin6319603569889696958 as select v28*aggView5964323102213219661.annot as v28, aggJoin6666861038331899805.annot * aggView5964323102213219661.annot as annot from aggJoin6666861038331899805 join aggView5964323102213219661 using(v17);
select (SUM(v28) / 7.0) as v29 from aggJoin6319603569889696958;
