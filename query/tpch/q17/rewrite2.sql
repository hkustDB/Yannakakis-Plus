create or replace view aggView4165172904502534274 as select p_partkey as v17 from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggJoin8697939735496133404 as select l_partkey as v17, l_quantity as v5, l_extendedprice as v6 from lineitem as lineitem, aggView4165172904502534274 where lineitem.l_partkey=aggView4165172904502534274.v17;
create or replace view aggView7721222172295552287 as select v1_partkey as v17, v1_quantity_avg as v27 from q17_inner as q17_inner;
create or replace view aggJoin7663372293109822607 as select v5, v6, v27 from aggJoin8697939735496133404 join aggView7721222172295552287 using(v17) where v5 > v27;
create or replace view aggView7022275167786157489 as select v6, COUNT(*) as annot from aggJoin7663372293109822607;
select (SUM((v6)* annot) / 7.0) as v29 from aggView7022275167786157489;
