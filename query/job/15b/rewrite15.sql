create or replace view aggJoin8095429178690786522 as (
with aggView3799736677951471310 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select id as v40, title as v41, production_year as v44 from title as t, aggView3799736677951471310 where t.id=aggView3799736677951471310.v40 and production_year<=2010 and production_year>=2005);
create or replace view aggJoin1435795034871201076 as (
with aggView1921573801818220028 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView1921573801818220028 where mi.info_type_id=aggView1921573801818220028.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin2668062657582056232 as (
with aggView918201748929167906 as (select v40, MIN(v35) as v52 from aggJoin1435795034871201076 group by v40)
select v40, v41, v44, v52 from aggJoin8095429178690786522 join aggView918201748929167906 using(v40));
create or replace view aggJoin1324366677533271544 as (
with aggView7435699214181195199 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView7435699214181195199 where mc.company_id=aggView7435699214181195199.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin3703897850920755978 as (
with aggView6511267722129995808 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin1324366677533271544 join aggView6511267722129995808 using(v20));
create or replace view aggJoin1509672840352150846 as (
with aggView1070186124098681729 as (select v40 from aggJoin3703897850920755978 group by v40)
select v40, v41, v44, v52 as v52 from aggJoin2668062657582056232 join aggView1070186124098681729 using(v40));
create or replace view aggJoin5787973043307668235 as (
with aggView9018705998715952045 as (select v40, MIN(v52) as v52, MIN(v41) as v53 from aggJoin1509672840352150846 group by v40,v52)
select keyword_id as v24, v52, v53 from movie_keyword as mk, aggView9018705998715952045 where mk.movie_id=aggView9018705998715952045.v40);
create or replace view aggJoin366387900340738612 as (
with aggView7434272148479493209 as (select id as v24 from keyword as k)
select v52, v53 from aggJoin5787973043307668235 join aggView7434272148479493209 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin366387900340738612;
