create or replace view aggJoin5824067260136514526 as (
with aggView9045115838208946520 as (select id as v26, name as v47 from name as n)
select movie_id as v3, v47 from cast_info as ci, aggView9045115838208946520 where ci.person_id=aggView9045115838208946520.v26);
create or replace view aggJoin400081876385456756 as (
with aggView3830234832888544617 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView3830234832888544617 where mc.company_id=aggView3830234832888544617.v20);
create or replace view aggJoin1646730706991453243 as (
with aggView1442535748196575030 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView1442535748196575030 where mk.keyword_id=aggView1442535748196575030.v25);
create or replace view aggJoin7461987471318371257 as (
with aggView3540725789753327171 as (select id as v3 from title as t)
select v3 from aggJoin1646730706991453243 join aggView3540725789753327171 using(v3));
create or replace view aggJoin9113946426146640843 as (
with aggView475562000690832604 as (select v3 from aggJoin7461987471318371257 group by v3)
select v3 from aggJoin400081876385456756 join aggView475562000690832604 using(v3));
create or replace view aggJoin6196232151826989359 as (
with aggView7259983179271386790 as (select v3 from aggJoin9113946426146640843 group by v3)
select v47 as v47 from aggJoin5824067260136514526 join aggView7259983179271386790 using(v3));
select MIN(v47) as v47 from aggJoin6196232151826989359;
