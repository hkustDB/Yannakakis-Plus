create or replace view aggView7082721968989746463 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin3147469753032577876 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView7082721968989746463 where mc.movie_id=aggView7082721968989746463.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView7704526830676371151 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin105765557619792403 as select v15, v9, v28, v29 from aggJoin3147469753032577876 join aggView7704526830676371151 using(v1);
create or replace view aggView6458273387501554809 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin105765557619792403 group by v15;
create or replace view aggJoin1304252850669919273 as select info_type_id as v3, v28, v29, v27 from movie_info_idx as mi_idx, aggView6458273387501554809 where mi_idx.movie_id=aggView6458273387501554809.v15;
create or replace view aggView4576401780244334426 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin5946672344107558901 as select v28, v29, v27 from aggJoin1304252850669919273 join aggView4576401780244334426 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5946672344107558901;
