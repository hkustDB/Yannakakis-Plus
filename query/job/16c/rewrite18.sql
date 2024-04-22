create or replace view aggJoin5155127887363582403 as (
with aggView8060953715646411154 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView8060953715646411154 where ci.person_id=aggView8060953715646411154.v2);
create or replace view aggJoin5222533037727433394 as (
with aggView4603977068153829872 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView4603977068153829872 where mk.keyword_id=aggView4603977068153829872.v33);
create or replace view aggJoin5179913686583020168 as (
with aggView3632645717622156218 as (select v11 from aggJoin5222533037727433394 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView3632645717622156218 where t.id=aggView3632645717622156218.v11 and episode_nr<100);
create or replace view aggJoin7931992305669822830 as (
with aggView721911317005233640 as (select v11, MIN(v44) as v56 from aggJoin5179913686583020168 group by v11)
select movie_id as v11, company_id as v28, v56 from movie_companies as mc, aggView721911317005233640 where mc.movie_id=aggView721911317005233640.v11);
create or replace view aggJoin7116304828091343716 as (
with aggView6902848674981920682 as (select id as v28 from company_name as cn where country_code= '[us]')
select v11, v56 from aggJoin7931992305669822830 join aggView6902848674981920682 using(v28));
create or replace view aggJoin6755118308270120760 as (
with aggView3474287388052680480 as (select v11, MIN(v56) as v56 from aggJoin7116304828091343716 group by v11,v56)
select v2, v55 as v55, v56 from aggJoin5155127887363582403 join aggView3474287388052680480 using(v11));
create or replace view aggJoin2112902602684419648 as (
with aggView5538017030659767477 as (select id as v2 from name as n)
select v55, v56 from aggJoin6755118308270120760 join aggView5538017030659767477 using(v2));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin2112902602684419648;
