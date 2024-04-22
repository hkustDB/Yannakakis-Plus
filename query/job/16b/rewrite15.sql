create or replace view aggJoin6051090368981987958 as (
with aggView2227027818631614627 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select id as v2, v55 from name as n, aggView2227027818631614627 where n.id=aggView2227027818631614627.v2);
create or replace view aggJoin511461194055384502 as (
with aggView2239163040980104444 as (select id as v11, title as v56 from title as t)
select person_id as v2, movie_id as v11, v56 from cast_info as ci, aggView2239163040980104444 where ci.movie_id=aggView2239163040980104444.v11);
create or replace view aggJoin5251797156458782406 as (
with aggView8956708263111598113 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView8956708263111598113 where mk.keyword_id=aggView8956708263111598113.v33);
create or replace view aggJoin5554815693396551002 as (
with aggView8392599520580038963 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView8392599520580038963 where mc.company_id=aggView8392599520580038963.v28);
create or replace view aggJoin2620551841127109118 as (
with aggView6307997534932547244 as (select v2, MIN(v55) as v55 from aggJoin6051090368981987958 group by v2,v55)
select v11, v56 as v56, v55 from aggJoin511461194055384502 join aggView6307997534932547244 using(v2));
create or replace view aggJoin8658655851964456594 as (
with aggView8006469201226859400 as (select v11 from aggJoin5251797156458782406 group by v11)
select v11 from aggJoin5554815693396551002 join aggView8006469201226859400 using(v11));
create or replace view aggJoin8197976726029736607 as (
with aggView5507192169248828747 as (select v11 from aggJoin8658655851964456594 group by v11)
select v56 as v56, v55 as v55 from aggJoin2620551841127109118 join aggView5507192169248828747 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin8197976726029736607;
