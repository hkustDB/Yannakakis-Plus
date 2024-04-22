create or replace view aggJoin2434966682273554330 as (
with aggView250620831161006057 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView250620831161006057 where mk.keyword_id=aggView250620831161006057.v25);
create or replace view aggJoin1729041739625555242 as (
with aggView10374800692242092 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView10374800692242092 where mc.company_id=aggView10374800692242092.v20);
create or replace view aggJoin2120088103138321601 as (
with aggView2669699511240398572 as (select v3 from aggJoin1729041739625555242 group by v3)
select id as v3 from title as t, aggView2669699511240398572 where t.id=aggView2669699511240398572.v3);
create or replace view aggJoin6876177152009146664 as (
with aggView5400723280491181273 as (select v3 from aggJoin2120088103138321601 group by v3)
select v3 from aggJoin2434966682273554330 join aggView5400723280491181273 using(v3));
create or replace view aggJoin534635915466601311 as (
with aggView5279160169876716946 as (select v3 from aggJoin6876177152009146664 group by v3)
select person_id as v26 from cast_info as ci, aggView5279160169876716946 where ci.movie_id=aggView5279160169876716946.v3);
create or replace view aggJoin5939948487348339193 as (
with aggView8804900194048497107 as (select v26 from aggJoin534635915466601311 group by v26)
select name as v27 from name as n, aggView8804900194048497107 where n.id=aggView8804900194048497107.v26 and name LIKE '%B%');
create or replace view aggView395690600120987975 as select v27 from aggJoin5939948487348339193 group by v27;
select MIN(v27) as v47 from aggView395690600120987975;
