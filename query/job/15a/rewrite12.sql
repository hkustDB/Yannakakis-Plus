create or replace view aggJoin8278443659529235910 as (
with aggView106877841396106304 as (select id as v40, title as v53 from title as t where production_year>2000)
select movie_id as v40, keyword_id as v24, v53 from movie_keyword as mk, aggView106877841396106304 where mk.movie_id=aggView106877841396106304.v40);
create or replace view aggJoin4661883474660676791 as (
with aggView3633710157715762713 as (select id as v24 from keyword as k)
select v40, v53 from aggJoin8278443659529235910 join aggView3633710157715762713 using(v24));
create or replace view aggJoin6314174657299369725 as (
with aggView2318119612797649941 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView2318119612797649941 where mc.company_id=aggView2318119612797649941.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin766235912997644650 as (
with aggView5137033256628437996 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin6314174657299369725 join aggView5137033256628437996 using(v20));
create or replace view aggJoin2551970315427971372 as (
with aggView901891140644153157 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView901891140644153157 where mi.info_type_id=aggView901891140644153157.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin1715180572782744045 as (
with aggView7625449139237475538 as (select v40, MIN(v35) as v52 from aggJoin2551970315427971372 group by v40)
select movie_id as v40, v52 from aka_title as aka_t, aggView7625449139237475538 where aka_t.movie_id=aggView7625449139237475538.v40);
create or replace view aggJoin497159031826089686 as (
with aggView5603051807039732593 as (select v40 from aggJoin766235912997644650 group by v40)
select v40, v52 as v52 from aggJoin1715180572782744045 join aggView5603051807039732593 using(v40));
create or replace view aggJoin664998455002163464 as (
with aggView2645455401611468592 as (select v40, MIN(v52) as v52 from aggJoin497159031826089686 group by v40,v52)
select v53 as v53, v52 from aggJoin4661883474660676791 join aggView2645455401611468592 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin664998455002163464;
