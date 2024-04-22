create or replace view aggJoin4550021430278806666 as (
with aggView6706880664030234998 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView6706880664030234998 where mc.company_id=aggView6706880664030234998.v20);
create or replace view aggJoin3890692981023179109 as (
with aggView5554044966061187656 as (select v3 from aggJoin4550021430278806666 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView5554044966061187656 where ci.movie_id=aggView5554044966061187656.v3);
create or replace view aggJoin5529732234110016024 as (
with aggView5090815619129567383 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView5090815619129567383 where mk.keyword_id=aggView5090815619129567383.v25);
create or replace view aggJoin7656466753851531478 as (
with aggView7403198305770561227 as (select id as v3 from title as t)
select v3 from aggJoin5529732234110016024 join aggView7403198305770561227 using(v3));
create or replace view aggJoin8652189139543679058 as (
with aggView5210315767844905536 as (select v3 from aggJoin7656466753851531478 group by v3)
select v26 from aggJoin3890692981023179109 join aggView5210315767844905536 using(v3));
create or replace view aggJoin7281063172789301451 as (
with aggView334414090185186479 as (select v26 from aggJoin8652189139543679058 group by v26)
select name as v27 from name as n, aggView334414090185186479 where n.id=aggView334414090185186479.v26);
create or replace view aggJoin630405634945487268 as (
with aggView1016976764382640566 as (select v27 from aggJoin7281063172789301451 group by v27)
select v27 from aggView1016976764382640566 where v27 LIKE '%Bert%');
select MIN(v27) as v47 from aggJoin630405634945487268;
