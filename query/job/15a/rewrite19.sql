create or replace view aggJoin4880525509940467561 as (
with aggView7894588047901781359 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView7894588047901781359 where mk.keyword_id=aggView7894588047901781359.v24);
create or replace view aggJoin2414468109361146294 as (
with aggView8117063821477597919 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView8117063821477597919 where mc.company_id=aggView8117063821477597919.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin3843808439184952403 as (
with aggView8683464725572623233 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select v40 from aggJoin4880525509940467561 join aggView8683464725572623233 using(v40));
create or replace view aggJoin5598740182127632585 as (
with aggView7238313116679930259 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin2414468109361146294 join aggView7238313116679930259 using(v20));
create or replace view aggJoin5994307658838325499 as (
with aggView5392724424628966812 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView5392724424628966812 where mi.info_type_id=aggView5392724424628966812.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin3352273244056133811 as (
with aggView7248607391184574007 as (select v40, MIN(v35) as v52 from aggJoin5994307658838325499 group by v40)
select v40, v52 from aggJoin3843808439184952403 join aggView7248607391184574007 using(v40));
create or replace view aggJoin8195330869517982461 as (
with aggView497725090468394638 as (select v40 from aggJoin5598740182127632585 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView497725090468394638 where t.id=aggView497725090468394638.v40 and production_year>2000);
create or replace view aggJoin7171908182700824394 as (
with aggView7083284301449964789 as (select v40, MIN(v41) as v53 from aggJoin8195330869517982461 group by v40)
select v52 as v52, v53 from aggJoin3352273244056133811 join aggView7083284301449964789 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin7171908182700824394;
