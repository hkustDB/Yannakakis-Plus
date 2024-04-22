create or replace view aggJoin7930229308090672309 as (
with aggView7137521150430420526 as (select id as v15, title as v28, production_year as v29 from title as t where production_year>2010)
select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView7137521150430420526 where mc.movie_id=aggView7137521150430420526.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%');
create or replace view aggJoin7867588654060642159 as (
with aggView3559483959528216829 as (select id as v1 from company_type as ct where kind= 'production companies')
select v15, v9, v28, v29 from aggJoin7930229308090672309 join aggView3559483959528216829 using(v1));
create or replace view aggJoin422827522527792372 as (
with aggView1585950226662030411 as (select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin7867588654060642159 group by v15,v29,v28)
select info_type_id as v3, v28, v29, v27 from movie_info_idx as mi_idx, aggView1585950226662030411 where mi_idx.movie_id=aggView1585950226662030411.v15);
create or replace view aggJoin8155336765800368043 as (
with aggView3715775095320575535 as (select id as v3 from info_type as it where info= 'top 250 rank')
select v28, v29, v27 from aggJoin422827522527792372 join aggView3715775095320575535 using(v3));
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin8155336765800368043;
