create or replace view aggView7672876977850513546 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin3712918020110540568 as select movie_id as v15 from movie_info_idx as mi_idx, aggView7672876977850513546 where mi_idx.info_type_id=aggView7672876977850513546.v3;
create or replace view aggView4186966731874654760 as select v15 from aggJoin3712918020110540568 group by v15;
create or replace view aggJoin1255525148212777252 as select id as v15, title as v16, production_year as v19 from title as t, aggView4186966731874654760 where t.id=aggView4186966731874654760.v15 and production_year>2000;
create or replace view aggView4222900656284511923 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin1255525148212777252 group by v15;
create or replace view aggJoin1527240737928792027 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView4222900656284511923 where mc.movie_id=aggView4222900656284511923.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1452954694603231515 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3889956826096668409 as select v9, v28, v29 from aggJoin1527240737928792027 join aggView1452954694603231515 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3889956826096668409;
