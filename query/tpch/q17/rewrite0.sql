create or replace view aggView3018400008288816173 as select v1_partkey as v17, v1_quantity_avg as v27 from q17_inner as q17_inner;
create or replace view aggJoin7236056959625727510 as select p_partkey as v17, p_brand as v20, p_container as v23, v27 from part as part, aggView3018400008288816173 where part.p_partkey=aggView3018400008288816173.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggView3560782076889309167 as select v17, COUNT(*) as annot, v27 from aggJoin7236056959625727510 group by v17,v27;
create or replace view aggJoin8017813966117349601 as select l_quantity as v5, l_extendedprice as v6, v27, annot from lineitem as lineitem, aggView3560782076889309167 where lineitem.l_partkey=aggView3560782076889309167.v17 and l_quantity>v27;
create or replace view aggView4731888685728949702 as select v6, SUM(annot) as annot from aggJoin8017813966117349601 group by v6;
select (SUM((v6)* annot) / 7.0) as v29 from aggView4731888685728949702;
