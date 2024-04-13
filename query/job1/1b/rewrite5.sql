create or replace view aggView2069956660808369988 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin8397517683349964381 as select movie_id as v15 from movie_info_idx as mi_idx, aggView2069956660808369988 where mi_idx.info_type_id=aggView2069956660808369988.v3;
create or replace view aggView6168853478758487517 as select v15 from aggJoin8397517683349964381 group by v15;
create or replace view aggJoin926364343257343306 as select id as v15, title as v16, production_year as v19 from title as t, aggView6168853478758487517 where t.id=aggView6168853478758487517.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView5875717768207719070 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin926364343257343306 group by v15;
create or replace view aggJoin7453295727322277961 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView5875717768207719070 where mc.movie_id=aggView5875717768207719070.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView7022223235285238799 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6966313789775436315 as select v9, v28, v29 from aggJoin7453295727322277961 join aggView7022223235285238799 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin6966313789775436315;
