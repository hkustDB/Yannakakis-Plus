create or replace view aggView5192885443205946430 as select p_partkey as v17, COUNT(*) as annot from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX' group by p_partkey;
create or replace view aggJoin2068386380569656501 as select v1_partkey as v17, v1_quantity_avg as v27, annot from q17_inner as q17_inner, aggView5192885443205946430 where q17_inner.v1_partkey=aggView5192885443205946430.v17;
create or replace view aggView7770954829048567711 as select v17, SUM(annot) as annot, v27 from aggJoin2068386380569656501 group by v17,v27;
create or replace view aggJoin1766240450394623601 as select l_extendedprice as v6, annot from lineitem as lineitem, aggView7770954829048567711 where lineitem.l_partkey=aggView7770954829048567711.v17 and l_quantity>v27;
select (SUM(v6*annot) / 7.0) as v29 from aggJoin1766240450394623601;
