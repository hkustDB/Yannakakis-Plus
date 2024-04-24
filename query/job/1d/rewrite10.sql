create or replace view aggView1501983102335500953 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin2287129749786249705 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView1501983102335500953 where mc.movie_id=aggView1501983102335500953.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView5031276190575185129 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3482534993626141427 as select v15, v9, v28, v29 from aggJoin2287129749786249705 join aggView5031276190575185129 using(v1);
create or replace view aggView7405427598066999598 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin3482534993626141427 group by v15,v29,v28;
create or replace view aggJoin3040551623677189305 as select info_type_id as v3, v28, v29, v27 from movie_info_idx as mi_idx, aggView7405427598066999598 where mi_idx.movie_id=aggView7405427598066999598.v15;
create or replace view aggView1525734169795962340 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin6154667982795430337 as select v28, v29, v27 from aggJoin3040551623677189305 join aggView1525734169795962340 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin6154667982795430337;
