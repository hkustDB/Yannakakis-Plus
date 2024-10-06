create or replace view aggView5710498063165336812 as select p_partkey as v17 from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggJoin2598010383334003102 as select l_partkey as v17, l_quantity as v5, l_extendedprice as v6 from lineitem as lineitem, aggView5710498063165336812 where lineitem.l_partkey=aggView5710498063165336812.v17;
create or replace view aggView7792792442176328202 as select v1_partkey as v17, v1_quantity_avg as v27 from q17_inner as q17_inner;
create or replace view aggJoin5557030702367161804 as select v5, v6, v27 from aggJoin2598010383334003102 join aggView7792792442176328202 using(v17) where v5 > v27;
create or replace view aggView7390095013235252201 as select v6, COUNT(*) as annot from aggJoin5557030702367161804 group by v6;
select (SUM((v6)* annot) / 7.0) as v29 from aggView7390095013235252201;
