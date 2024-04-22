create or replace view aggJoin1233925455634669942 as (
with aggView2344006019170859834 as (select id as v15, title as v28, production_year as v29 from title as t where production_year>2010)
select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView2344006019170859834 where mi_idx.movie_id=aggView2344006019170859834.v15);
create or replace view aggJoin7873428687140785507 as (
with aggView7537534361607092380 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView7537534361607092380 where mc.company_type_id=aggView7537534361607092380.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%');
create or replace view aggJoin407851249194340945 as (
with aggView5234987052102239089 as (select v15, MIN(v9) as v27 from aggJoin7873428687140785507 group by v15)
select v3, v28 as v28, v29 as v29, v27 from aggJoin1233925455634669942 join aggView5234987052102239089 using(v15));
create or replace view aggJoin1368870775763765833 as (
with aggView6202408242333615185 as (select id as v3 from info_type as it where info= 'top 250 rank')
select v28, v29, v27 from aggJoin407851249194340945 join aggView6202408242333615185 using(v3));
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin1368870775763765833;
