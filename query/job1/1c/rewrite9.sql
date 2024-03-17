create or replace view aggView8560104644157234218 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin4490651391646926361 as select movie_id as v15 from movie_info_idx as mi_idx, aggView8560104644157234218 where mi_idx.info_type_id=aggView8560104644157234218.v3;
create or replace view aggView1731628976807574621 as select v15 from aggJoin4490651391646926361 group by v15;
create or replace view aggJoin468900792835269706 as select id as v15, title as v16, production_year as v19 from title as t, aggView1731628976807574621 where t.id=aggView1731628976807574621.v15 and production_year>2010;
create or replace view aggView6948768057639881114 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7904024133957352386 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6948768057639881114 where mc.company_type_id=aggView6948768057639881114.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView7280407624936024623 as select v15, MIN(v9) as v27 from aggJoin7904024133957352386 group by v15;
create or replace view aggJoin5266954093024994701 as select v16, v19, v27 from aggJoin468900792835269706 join aggView7280407624936024623 using(v15);
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin5266954093024994701;
