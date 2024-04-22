create or replace view aggJoin4070273271483451416 as (
with aggView3781756526039811682 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView3781756526039811682 where mc.company_id=aggView3781756526039811682.v13);
create or replace view aggJoin5366726939870529406 as (
with aggView4224356361536763464 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView4224356361536763464 where mk.keyword_id=aggView4224356361536763464.v24);
create or replace view aggJoin936862490490299041 as (
with aggView7583445964331332981 as (select id as v20 from company_type as ct)
select v40 from aggJoin4070273271483451416 join aggView7583445964331332981 using(v20));
create or replace view aggJoin5398980563105279721 as (
with aggView1290684111262783486 as (select v40 from aggJoin936862490490299041 group by v40)
select movie_id as v40, info_type_id as v22, info as v35, note as v36 from movie_info as mi, aggView1290684111262783486 where mi.movie_id=aggView1290684111262783486.v40 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggJoin8282624914860814945 as (
with aggView8139826764463860113 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select v40 from aggJoin5366726939870529406 join aggView8139826764463860113 using(v40));
create or replace view aggJoin3944948069446194444 as (
with aggView1691934277213885458 as (select id as v22 from info_type as it1 where info= 'release dates')
select v40, v35, v36 from aggJoin5398980563105279721 join aggView1691934277213885458 using(v22));
create or replace view aggJoin7527844648630076393 as (
with aggView9162026883795514945 as (select v40, MIN(v35) as v52 from aggJoin3944948069446194444 group by v40)
select id as v40, title as v41, production_year as v44, v52 from title as t, aggView9162026883795514945 where t.id=aggView9162026883795514945.v40 and production_year>1990);
create or replace view aggJoin8263222368819598799 as (
with aggView448048539805303342 as (select v40, MIN(v52) as v52, MIN(v41) as v53 from aggJoin7527844648630076393 group by v40,v52)
select v52, v53 from aggJoin8282624914860814945 join aggView448048539805303342 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin8263222368819598799;
