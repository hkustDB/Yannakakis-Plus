create or replace view aggView6408586245917458091 as select p_partkey as v17, COUNT(*) as annot from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX' group by p_partkey;
create or replace view aggJoin7270165578650413664 as select l_partkey as v17, l_quantity as v5, l_extendedprice as v6, annot from lineitem as lineitem, aggView6408586245917458091 where lineitem.l_partkey=aggView6408586245917458091.v17;
create or replace view aggView1167385496028128654 as select v17, SUM(v6 * annot) as v28, SUM(annot) as annot, v5 from aggJoin7270165578650413664 group by v17,v5;
create or replace view aggJoin7192113076490517060 as select v28, annot from view1 as view1, aggView1167385496028128654 where view1.v1_partkey=aggView1167385496028128654.v17 and v5>v1_quantity_avg;
select (SUM(v28) / 7.0) as v29 from aggJoin7192113076490517060;
