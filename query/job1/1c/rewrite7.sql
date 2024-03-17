create or replace view aggView7530918084726802862 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin8005638781306240887 as select movie_id as v15 from movie_info_idx as mi_idx, aggView7530918084726802862 where mi_idx.info_type_id=aggView7530918084726802862.v3;
create or replace view aggView2093616530841080856 as select v15 from aggJoin8005638781306240887 group by v15;
create or replace view aggJoin2979668099580781706 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView2093616530841080856 where mc.movie_id=aggView2093616530841080856.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView433571095015456816 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin821584594627250749 as select v15, v9 from aggJoin2979668099580781706 join aggView433571095015456816 using(v1);
create or replace view aggView7052422075640174396 as select v15, MIN(v9) as v27 from aggJoin821584594627250749 group by v15;
create or replace view aggJoin7323234641937896014 as select title as v16, production_year as v19, v27 from title as t, aggView7052422075640174396 where t.id=aggView7052422075640174396.v15 and production_year>2010;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin7323234641937896014;
