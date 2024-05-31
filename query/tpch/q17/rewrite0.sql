create or replace view aggView3340911639578278167 as select v1_partkey as v17, v1_quantity_avg as v27 from q17_inner as q17_inner;
create or replace view aggJoin2024517848472175611 as select p_partkey as v17, p_brand as v20, p_container as v23, v27 from part as part, aggView3340911639578278167 where part.p_partkey=aggView3340911639578278167.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggView4102754810894666436 as select v17, COUNT(*) as annot, v27 from aggJoin2024517848472175611 group by v17,v27;
create or replace view aggJoin2275886357179911944 as select l_quantity as v5, l_extendedprice as v6, v27, annot from lineitem as lineitem, aggView4102754810894666436 where lineitem.l_partkey=aggView4102754810894666436.v17 and l_quantity>v27;
create or replace view aggView444543935825171023 as select v6, SUM(annot) as annot from aggJoin2275886357179911944 group by v6;
select (SUM((v6)* annot) / 7.0) as v29 from aggView444543935825171023;
