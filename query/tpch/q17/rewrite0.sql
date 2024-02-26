create or replace view aggView7933352324680818677 as select v1_partkey as v17, v1_quantity_avg as v27 from q17_inner as q17_inner;
create or replace view aggJoin2328617397606743997 as select p_partkey as v17, p_brand as v20, p_container as v23, v27 from part as part, aggView7933352324680818677 where part.p_partkey=aggView7933352324680818677.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggView7688969000663361034 as select v17, count(*) as annot, v27 from aggJoin2328617397606743997 group by v17,v27;
create or replace view aggJoin4716274597591335726 as select l_extendedprice as v6, annot from lineitem as lineitem, aggView7688969000663361034 where lineitem.l_partkey=aggView7688969000663361034.v17 and l_quantity>v27;
select (SUM(v6*annot) / 7.0) as v29 from aggJoin4716274597591335726;
