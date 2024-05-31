create or replace view aggView5979943806020505318 as select p_partkey as v17 from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggJoin7588704791512055990 as select v1_partkey as v17, v1_quantity_avg as v27 from q17_inner as q17_inner, aggView5979943806020505318 where q17_inner.v1_partkey=aggView5979943806020505318.v17;
create or replace view aggView4708443004800013742 as select v17, COUNT(*) as annot, v27 from aggJoin7588704791512055990 group by v17,v27;
create or replace view aggJoin5780384174043440328 as select l_quantity as v5, l_extendedprice as v6, v27, annot from lineitem as lineitem, aggView4708443004800013742 where lineitem.l_partkey=aggView4708443004800013742.v17 and l_quantity>v27;
create or replace view aggView7208265114630564323 as select v6, SUM(annot) as annot from aggJoin5780384174043440328 group by v6;
select (SUM((v6)* annot) / 7.0) as v29 from aggView7208265114630564323;
