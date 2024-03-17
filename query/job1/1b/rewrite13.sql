create or replace view aggView7511882513525266091 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin1148922535262543825 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView7511882513525266091 where mi_idx.movie_id=aggView7511882513525266091.v15;
create or replace view aggView8916030568947956227 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4187757622486946901 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8916030568947956227 where mc.company_type_id=aggView8916030568947956227.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView2906920516296232665 as select v15, MIN(v9) as v27 from aggJoin4187757622486946901 group by v15;
create or replace view aggJoin6404848680120566406 as select v3, v28 as v28, v29 as v29, v27 from aggJoin1148922535262543825 join aggView2906920516296232665 using(v15);
create or replace view aggView1532403689242986647 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin5497576489308068860 as select v28, v29, v27 from aggJoin6404848680120566406 join aggView1532403689242986647 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5497576489308068860;
