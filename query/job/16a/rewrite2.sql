create or replace view aggJoin8148258904957358181 as (
with aggView8637352444805276356 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView8637352444805276356 where mk.keyword_id=aggView8637352444805276356.v33);
create or replace view aggJoin5667658151758441253 as (
with aggView7869088545151129690 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView7869088545151129690 where mc.company_id=aggView7869088545151129690.v28);
create or replace view aggJoin5228184166488519150 as (
with aggView3161149237642032211 as (select v11 from aggJoin8148258904957358181 group by v11)
select v11 from aggJoin5667658151758441253 join aggView3161149237642032211 using(v11));
create or replace view aggJoin4088679060621552630 as (
with aggView4862030910597202321 as (select v11 from aggJoin5228184166488519150 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView4862030910597202321 where t.id=aggView4862030910597202321.v11 and episode_nr>=50 and episode_nr<100);
create or replace view aggView2545001118433513604 as select v11, v44 from aggJoin4088679060621552630 group by v11,v44;
create or replace view aggJoin8650864355346446656 as (
with aggView4898962731285772743 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView4898962731285772743 where an.person_id=aggView4898962731285772743.v2);
create or replace view aggView3149754733774038660 as select v2, v3 from aggJoin8650864355346446656 group by v2,v3;
create or replace view aggJoin1145969500585731341 as (
with aggView4960539274368904907 as (select v2, MIN(v3) as v55 from aggView3149754733774038660 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView4960539274368904907 where ci.person_id=aggView4960539274368904907.v2);
create or replace view aggJoin3786440404069148214 as (
with aggView3670648383357372484 as (select v11, MIN(v55) as v55 from aggJoin1145969500585731341 group by v11,v55)
select v44, v55 from aggView2545001118433513604 join aggView3670648383357372484 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin3786440404069148214;
