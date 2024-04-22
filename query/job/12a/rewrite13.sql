create or replace view aggJoin424509846359373150 as (
with aggView6166002560045158204 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView6166002560045158204 where mc.company_id=aggView6166002560045158204.v1);
create or replace view aggJoin2075990834518673726 as (
with aggView1577644449407680649 as (select id as v29, title as v43 from title as t where production_year<=2008 and production_year>=2005)
select movie_id as v29, info_type_id as v21, info as v22, v43 from movie_info as mi, aggView1577644449407680649 where mi.movie_id=aggView1577644449407680649.v29 and info IN ('Drama','Horror'));
create or replace view aggJoin2640536295042249134 as (
with aggView964553750706860020 as (select id as v21 from info_type as it1 where info= 'genres')
select v29, v22, v43 from aggJoin2075990834518673726 join aggView964553750706860020 using(v21));
create or replace view aggJoin6687854683251772795 as (
with aggView3544030474907272616 as (select v29, MIN(v43) as v43 from aggJoin2640536295042249134 group by v29,v43)
select movie_id as v29, info_type_id as v26, info as v27, v43 from movie_info_idx as mi_idx, aggView3544030474907272616 where mi_idx.movie_id=aggView3544030474907272616.v29 and info>'8.0');
create or replace view aggJoin1737344041572211139 as (
with aggView3395691014958328933 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin424509846359373150 join aggView3395691014958328933 using(v8));
create or replace view aggJoin4161091043799443923 as (
with aggView900587933877056432 as (select id as v26 from info_type as it2 where info= 'rating')
select v29, v27, v43 from aggJoin6687854683251772795 join aggView900587933877056432 using(v26));
create or replace view aggJoin4705398294744814843 as (
with aggView4302287914235692545 as (select v29, MIN(v43) as v43, MIN(v27) as v42 from aggJoin4161091043799443923 group by v29,v43)
select v41 as v41, v43, v42 from aggJoin1737344041572211139 join aggView4302287914235692545 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin4705398294744814843;
