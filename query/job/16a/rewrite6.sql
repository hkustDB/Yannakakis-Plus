create or replace view aggJoin9133919008712469564 as (
with aggView7844073532815749377 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select id as v2, v55 from name as n, aggView7844073532815749377 where n.id=aggView7844073532815749377.v2);
create or replace view aggJoin1221584663489787469 as (
with aggView1968731995945246360 as (select v2, MIN(v55) as v55 from aggJoin9133919008712469564 group by v2,v55)
select movie_id as v11, v55 from cast_info as ci, aggView1968731995945246360 where ci.person_id=aggView1968731995945246360.v2);
create or replace view aggJoin3726700574904739342 as (
with aggView8284841784904942410 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView8284841784904942410 where mc.company_id=aggView8284841784904942410.v28);
create or replace view aggJoin726812931512135387 as (
with aggView6179805538732002661 as (select v11 from aggJoin3726700574904739342 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView6179805538732002661 where t.id=aggView6179805538732002661.v11 and episode_nr>=50 and episode_nr<100);
create or replace view aggJoin2627723699554693760 as (
with aggView6848514466730435058 as (select v11, MIN(v44) as v56 from aggJoin726812931512135387 group by v11)
select movie_id as v11, keyword_id as v33, v56 from movie_keyword as mk, aggView6848514466730435058 where mk.movie_id=aggView6848514466730435058.v11);
create or replace view aggJoin3130275236623203223 as (
with aggView2702188095943586640 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select v11, v56 from aggJoin2627723699554693760 join aggView2702188095943586640 using(v33));
create or replace view aggJoin7573293205389780979 as (
with aggView3996340141491335544 as (select v11, MIN(v56) as v56 from aggJoin3130275236623203223 group by v11,v56)
select v55 as v55, v56 from aggJoin1221584663489787469 join aggView3996340141491335544 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin7573293205389780979;
