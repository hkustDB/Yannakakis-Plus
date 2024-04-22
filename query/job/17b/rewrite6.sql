create or replace view aggJoin7987993728173682471 as (
with aggView8230899718320782366 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView8230899718320782366 where mc.company_id=aggView8230899718320782366.v20);
create or replace view aggJoin5388419928874943750 as (
with aggView6983897660609346041 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView6983897660609346041 where mk.keyword_id=aggView6983897660609346041.v25);
create or replace view aggJoin6507508869609514736 as (
with aggView8944799458291408459 as (select v3 from aggJoin5388419928874943750 group by v3)
select v3 from aggJoin7987993728173682471 join aggView8944799458291408459 using(v3));
create or replace view aggJoin2471479492964624757 as (
with aggView6808348533550827252 as (select v3 from aggJoin6507508869609514736 group by v3)
select id as v3 from title as t, aggView6808348533550827252 where t.id=aggView6808348533550827252.v3);
create or replace view aggJoin479999566949824434 as (
with aggView8331618692591521715 as (select v3 from aggJoin2471479492964624757 group by v3)
select person_id as v26 from cast_info as ci, aggView8331618692591521715 where ci.movie_id=aggView8331618692591521715.v3);
create or replace view aggJoin6984360153768555329 as (
with aggView5629696518757495974 as (select v26 from aggJoin479999566949824434 group by v26)
select name as v27 from name as n, aggView5629696518757495974 where n.id=aggView5629696518757495974.v26);
create or replace view aggJoin5536233944105501000 as (
with aggView7092971192517686874 as (select v27 from aggJoin6984360153768555329 group by v27)
select v27 from aggView7092971192517686874 where v27 LIKE 'Z%');
select MIN(v27) as v47 from aggJoin5536233944105501000;
