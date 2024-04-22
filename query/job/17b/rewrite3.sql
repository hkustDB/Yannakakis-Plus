create or replace view aggJoin354944887348399305 as (
with aggView5082800777743798841 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView5082800777743798841 where mc.company_id=aggView5082800777743798841.v20);
create or replace view aggJoin3775447064725755523 as (
with aggView5013686650176809001 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView5013686650176809001 where mk.keyword_id=aggView5013686650176809001.v25);
create or replace view aggJoin6880070494376044566 as (
with aggView1618627418991249707 as (select v3 from aggJoin3775447064725755523 group by v3)
select id as v3 from title as t, aggView1618627418991249707 where t.id=aggView1618627418991249707.v3);
create or replace view aggJoin1405591999470389790 as (
with aggView3690395766432886677 as (select v3 from aggJoin6880070494376044566 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView3690395766432886677 where ci.movie_id=aggView3690395766432886677.v3);
create or replace view aggJoin7805238381868822312 as (
with aggView2820943216781792152 as (select v3 from aggJoin354944887348399305 group by v3)
select v26 from aggJoin1405591999470389790 join aggView2820943216781792152 using(v3));
create or replace view aggJoin2957354096494704093 as (
with aggView7703917753973644717 as (select v26 from aggJoin7805238381868822312 group by v26)
select name as v27 from name as n, aggView7703917753973644717 where n.id=aggView7703917753973644717.v26);
create or replace view aggJoin9021295024124849497 as (
with aggView7607217829314260117 as (select v27 from aggJoin2957354096494704093 group by v27)
select v27 from aggView7607217829314260117 where v27 LIKE 'Z%');
select MIN(v27) as v47 from aggJoin9021295024124849497;
