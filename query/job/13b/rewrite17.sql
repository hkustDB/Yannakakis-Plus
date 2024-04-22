create or replace view aggJoin5540960460218400444 as (
with aggView8941673347270874089 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView8941673347270874089 where mc.company_id=aggView8941673347270874089.v1);
create or replace view aggJoin5879384736042634636 as (
with aggView3258216384087999891 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin5540960460218400444 join aggView3258216384087999891 using(v8));
create or replace view aggJoin8342667528847081269 as (
with aggView467050301794260812 as (select v22, MIN(v43) as v43 from aggJoin5879384736042634636 group by v22,v43)
select id as v22, title as v32, kind_id as v14, v43 from title as t, aggView467050301794260812 where t.id=aggView467050301794260812.v22 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggJoin2716830509405095172 as (
with aggView7876297414446785392 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView7876297414446785392 where mi.info_type_id=aggView7876297414446785392.v12);
create or replace view aggJoin3343888369595535117 as (
with aggView6997175704256277714 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView6997175704256277714 where miidx.info_type_id=aggView6997175704256277714.v10);
create or replace view aggJoin4020173441665791882 as (
with aggView609866785533671309 as (select v22, MIN(v29) as v44 from aggJoin3343888369595535117 group by v22)
select v22, v32, v14, v43 as v43, v44 from aggJoin8342667528847081269 join aggView609866785533671309 using(v22));
create or replace view aggJoin4806944024603003453 as (
with aggView8574621743961354268 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32, v43, v44 from aggJoin4020173441665791882 join aggView8574621743961354268 using(v14));
create or replace view aggJoin4757451978280201796 as (
with aggView3965794706608602560 as (select v22, MIN(v43) as v43, MIN(v44) as v44, MIN(v32) as v45 from aggJoin4806944024603003453 group by v22,v43,v44)
select v43, v44, v45 from aggJoin2716830509405095172 join aggView3965794706608602560 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin4757451978280201796;
