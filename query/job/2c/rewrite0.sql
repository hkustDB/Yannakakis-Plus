create or replace view aggJoin5245377787264170286 as (
with aggView69413861323626942 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v12 from movie_keyword as mk, aggView69413861323626942 where mk.keyword_id=aggView69413861323626942.v18);
create or replace view aggJoin685707206576176310 as (
with aggView8878268860429890400 as (select id as v1 from company_name as cn where country_code= '[sm]')
select movie_id as v12 from movie_companies as mc, aggView8878268860429890400 where mc.company_id=aggView8878268860429890400.v1);
create or replace view aggJoin308043435215510958 as (
with aggView5088487334576110022 as (select v12 from aggJoin5245377787264170286 group by v12)
select v12 from aggJoin685707206576176310 join aggView5088487334576110022 using(v12));
create or replace view aggJoin6309034402000675266 as (
with aggView2393254692232421712 as (select v12 from aggJoin308043435215510958 group by v12)
select title as v20 from title as t, aggView2393254692232421712 where t.id=aggView2393254692232421712.v12);
create or replace view aggView6073434416923358212 as select v20 from aggJoin6309034402000675266 group by v20;
select MIN(v20) as v31 from aggView6073434416923358212;
