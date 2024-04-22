create or replace view aggJoin6780756156863950595 as (
with aggView6356138076180432563 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v12 from movie_companies as mc, aggView6356138076180432563 where mc.company_id=aggView6356138076180432563.v1);
create or replace view aggJoin7658061112238092494 as (
with aggView4723429403382420634 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v12 from movie_keyword as mk, aggView4723429403382420634 where mk.keyword_id=aggView4723429403382420634.v18);
create or replace view aggJoin983049266554757489 as (
with aggView6832733443003422466 as (select v12 from aggJoin6780756156863950595 group by v12)
select v12 from aggJoin7658061112238092494 join aggView6832733443003422466 using(v12));
create or replace view aggJoin5487781774829917523 as (
with aggView2229286082766577066 as (select v12 from aggJoin983049266554757489 group by v12)
select title as v20 from title as t, aggView2229286082766577066 where t.id=aggView2229286082766577066.v12);
create or replace view aggView8711694302566844036 as select v20 from aggJoin5487781774829917523 group by v20;
select MIN(v20) as v31 from aggView8711694302566844036;
