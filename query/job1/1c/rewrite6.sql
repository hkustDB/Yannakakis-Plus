create or replace view aggView3225413721530228852 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin7459038444898375096 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView3225413721530228852 where mi_idx.movie_id=aggView3225413721530228852.v15;
create or replace view aggView723944464194730230 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin5834238451787630176 as select v15, v28, v29 from aggJoin7459038444898375096 join aggView723944464194730230 using(v3);
create or replace view aggView1721057311964196655 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8124317130770745427 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1721057311964196655 where mc.company_type_id=aggView1721057311964196655.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView128924003439102574 as select v15, MIN(v9) as v27 from aggJoin8124317130770745427 group by v15;
create or replace view aggJoin7963538257960100887 as select v28 as v28, v29 as v29, v27 from aggJoin5834238451787630176 join aggView128924003439102574 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin7963538257960100887;
