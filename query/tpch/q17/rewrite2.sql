create or replace view aggView7240907296702981952 as select v1_partkey as v17, COUNT(*) as annot, v1_quantity_avg as v27 from view1 as view1 group by v1_partkey,v1_quantity_avg;
create or replace view aggJoin3219641243832393329 as select p_partkey as v17, p_brand as v20, p_container as v23, v27, annot from part as part, aggView7240907296702981952 where part.p_partkey=aggView7240907296702981952.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggView2040922970596840244 as select v17, SUM(annot) as annot, v27 from aggJoin3219641243832393329 group by v17,v27;
create or replace view aggJoin3153165509098503891 as select l_extendedprice as v6, annot from lineitem as lineitem, aggView2040922970596840244 where lineitem.l_partkey=aggView2040922970596840244.v17 and l_quantity>v27;
select (SUM(v6*annot) / 7.0) as v29 from aggJoin3153165509098503891;
