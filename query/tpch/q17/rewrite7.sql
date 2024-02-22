create or replace view aggView4148472823895937100 as select p_partkey as v17, COUNT(*) as annot from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX' group by p_partkey;
create or replace view aggJoin1795795129688282403 as select v1_partkey as v17, v1_quantity_avg as v27, annot from view1 as view1, aggView4148472823895937100 where view1.v1_partkey=aggView4148472823895937100.v17;
create or replace view aggView7732228862085653283 as select v17, SUM(annot) as annot, v27 from aggJoin1795795129688282403 group by v17,v27;
create or replace view aggJoin2857564100040960635 as select l_extendedprice as v6, annot from lineitem as lineitem, aggView7732228862085653283 where lineitem.l_partkey=aggView7732228862085653283.v17 and l_quantity>v27;
select (SUM(v6*annot) / 7.0) as v29 from aggJoin2857564100040960635;
