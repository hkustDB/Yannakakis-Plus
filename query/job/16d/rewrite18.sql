create or replace view aggJoin4053717808308029717 as (
with aggView3168314495043784051 as (select id as v11, title as v56 from title as t where episode_nr>=5 and episode_nr<100)
select person_id as v2, movie_id as v11, v56 from cast_info as ci, aggView3168314495043784051 where ci.movie_id=aggView3168314495043784051.v11);
create or replace view aggJoin5313612260777829607 as (
with aggView3227399241849846750 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView3227399241849846750 where mc.company_id=aggView3227399241849846750.v28);
create or replace view aggJoin8365222326542484963 as (
with aggView512513111635654649 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView512513111635654649 where mk.keyword_id=aggView512513111635654649.v33);
create or replace view aggJoin3021559814565656429 as (
with aggView6060923055153259155 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView6060923055153259155 where an.person_id=aggView6060923055153259155.v2);
create or replace view aggJoin425011969934528633 as (
with aggView8979741611524518532 as (select v2, MIN(v3) as v55 from aggJoin3021559814565656429 group by v2)
select v11, v56 as v56, v55 from aggJoin4053717808308029717 join aggView8979741611524518532 using(v2));
create or replace view aggJoin7888136807266368957 as (
with aggView2817808234883542547 as (select v11 from aggJoin8365222326542484963 group by v11)
select v11 from aggJoin5313612260777829607 join aggView2817808234883542547 using(v11));
create or replace view aggJoin565455701736071035 as (
with aggView4672008662111349607 as (select v11 from aggJoin7888136807266368957 group by v11)
select v56 as v56, v55 as v55 from aggJoin425011969934528633 join aggView4672008662111349607 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin565455701736071035;
