create or replace view aggView3648951932327909214 as select v1_partkey as v17, v1_quantity_avg as v27 from q17_inner as q17_inner;
create or replace view aggJoin8080254537438174192 as select p_partkey as v17, p_brand as v20, p_container as v23, v27 from part as part, aggView3648951932327909214 where part.p_partkey=aggView3648951932327909214.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggView813074754695551948 as select v17, COUNT(*) as annot, v27 from aggJoin8080254537438174192 group by v17,v27;
create or replace view aggJoin3038703767871976629 as select l_quantity as v5, l_extendedprice as v6, v27, annot from lineitem as lineitem, aggView813074754695551948 where lineitem.l_partkey=aggView813074754695551948.v17 and l_quantity>v27;
create or replace view aggView7057984872625127804 as select v6, SUM(annot) as annot from aggJoin3038703767871976629;
select (SUM((v6)* annot) / 7.0) as v29 from aggView7057984872625127804;
