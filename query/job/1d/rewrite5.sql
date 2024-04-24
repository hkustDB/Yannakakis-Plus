create or replace view aggView2683972657397753277 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin5870263977137409342 as select movie_id as v15 from movie_info_idx as mi_idx, aggView2683972657397753277 where mi_idx.info_type_id=aggView2683972657397753277.v3;
create or replace view aggView1482287260564032804 as select v15 from aggJoin5870263977137409342 group by v15;
create or replace view aggJoin6256897727900099062 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView1482287260564032804 where mc.movie_id=aggView1482287260564032804.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView792476888508643476 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3509415580577229999 as select v15, v9 from aggJoin6256897727900099062 join aggView792476888508643476 using(v1);
create or replace view aggView7474235298538892917 as select v15, MIN(v9) as v27 from aggJoin3509415580577229999 group by v15;
create or replace view aggJoin2493297126293418603 as select title as v16, production_year as v19, v27 from title as t, aggView7474235298538892917 where t.id=aggView7474235298538892917.v15 and production_year>2000;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin2493297126293418603;
