create or replace view aggJoin6432032481283888785 as (
with aggView3611747210950934577 as (select id as v11, title as v56 from title as t where episode_nr>=5 and episode_nr<100)
select movie_id as v11, company_id as v28, v56 from movie_companies as mc, aggView3611747210950934577 where mc.movie_id=aggView3611747210950934577.v11);
create or replace view aggJoin2131519982906821186 as (
with aggView8579156120784709652 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView8579156120784709652 where ci.person_id=aggView8579156120784709652.v2);
create or replace view aggJoin1340551072136207995 as (
with aggView4034710153968295761 as (select id as v2 from name as n)
select v11, v55 from aggJoin2131519982906821186 join aggView4034710153968295761 using(v2));
create or replace view aggJoin7774607650611038665 as (
with aggView4573766310341779764 as (select id as v28 from company_name as cn where country_code= '[us]')
select v11, v56 from aggJoin6432032481283888785 join aggView4573766310341779764 using(v28));
create or replace view aggJoin5244202349498999996 as (
with aggView871623026918905155 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView871623026918905155 where mk.keyword_id=aggView871623026918905155.v33);
create or replace view aggJoin1380691983243809791 as (
with aggView38482964426014661 as (select v11 from aggJoin5244202349498999996 group by v11)
select v11, v56 as v56 from aggJoin7774607650611038665 join aggView38482964426014661 using(v11));
create or replace view aggJoin3292853973815360421 as (
with aggView2637792528926803731 as (select v11, MIN(v56) as v56 from aggJoin1380691983243809791 group by v11,v56)
select v55 as v55, v56 from aggJoin1340551072136207995 join aggView2637792528926803731 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin3292853973815360421;
