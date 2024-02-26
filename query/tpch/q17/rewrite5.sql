create or replace view aggView2305934603939687397 as select l_partkey as v17, SUM(l_extendedprice) as v28, l_quantity as v5 from lineitem as lineitem group by l_partkey,l_quantity;
create or replace view aggJoin4951446033454128549 as select p_partkey as v17, p_brand as v20, p_container as v23, v28, v5 from part as part, aggView2305934603939687397 where part.p_partkey=aggView2305934603939687397.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggView7682391452792550064 as select v1_partkey as v17, v1_quantity_avg as v27 from q17_inner as q17_inner;
create or replace view aggJoin3606443630746484923 as select v28 from aggJoin4951446033454128549 join aggView7682391452792550064 using(v17) where v5 > v27;
select (SUM(v28) / 7.0) as v29 from aggJoin3606443630746484923;
