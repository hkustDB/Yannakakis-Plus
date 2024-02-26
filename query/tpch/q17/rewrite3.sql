create or replace view aggView485379794343137306 as select l_partkey as v17, SUM(l_extendedprice) as v28, COUNT(*) as annot, l_quantity as v5 from lineitem as lineitem group by l_partkey,l_quantity;
create or replace view aggJoin2982336611041195550 as select p_partkey as v17, p_brand as v20, p_container as v23, v28, v5, annot from part as part, aggView485379794343137306 where part.p_partkey=aggView485379794343137306.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggView6554032422703409879 as select v17, SUM(v28) as v28, SUM(annot) as annot, v5 from aggJoin2982336611041195550 group by v17,v5;
create or replace view aggJoin4051184807062847763 as select v28, annot from q17_inner as q17_inner, aggView6554032422703409879 where q17_inner.v1_partkey=aggView6554032422703409879.v17 and v5>v1_quantity_avg;
select (SUM(v28) / 7.0) as v29 from aggJoin4051184807062847763;
