create or replace view aggView3095906823042592107 as select id as v15, title as v16, production_year as v19 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin98169997195254980 as (
with aggView7968483194555511517 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView7968483194555511517 where mc.company_type_id=aggView7968483194555511517.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%');
create or replace view aggJoin1668412008398014343 as (
with aggView3732504814988711777 as (select id as v3 from info_type as it where info= 'bottom 10 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView3732504814988711777 where mi_idx.info_type_id=aggView3732504814988711777.v3);
create or replace view aggJoin3391162672821649319 as (
with aggView8298139118840628890 as (select v15 from aggJoin1668412008398014343 group by v15)
select v15, v9 from aggJoin98169997195254980 join aggView8298139118840628890 using(v15));
create or replace view aggView4496977440340895548 as select v15, v9 from aggJoin3391162672821649319 group by v15,v9;
create or replace view aggJoin4832122223924510312 as (
with aggView7227014371864648130 as (select v15, MIN(v9) as v27 from aggView4496977440340895548 group by v15)
select v16, v19, v27 from aggView3095906823042592107 join aggView7227014371864648130 using(v15));
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin4832122223924510312;
