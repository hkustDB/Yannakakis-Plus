create or replace view aggView1502465852705411066 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin8297704775847367292 as select movie_id as v15 from movie_info_idx as mi_idx, aggView1502465852705411066 where mi_idx.info_type_id=aggView1502465852705411066.v3;
create or replace view aggView4228555264101323972 as select v15 from aggJoin8297704775847367292 group by v15;
create or replace view aggJoin7190523587953975421 as select id as v15, title as v16, production_year as v19 from title as t, aggView4228555264101323972 where t.id=aggView4228555264101323972.v15 and production_year>2000;
create or replace view aggView7664749029700176597 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin7190523587953975421 group by v15;
create or replace view aggJoin162711736369768965 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView7664749029700176597 where mc.movie_id=aggView7664749029700176597.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView992671115187216249 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1226601044880512518 as select v9, v28, v29 from aggJoin162711736369768965 join aggView992671115187216249 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin1226601044880512518;
