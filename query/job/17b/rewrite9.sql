create or replace view aggJoin6941852066470640245 as (
with aggView1869064204517108573 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView1869064204517108573 where mc.company_id=aggView1869064204517108573.v20);
create or replace view aggJoin1477575243388720998 as (
with aggView7310682628934212904 as (select v3 from aggJoin6941852066470640245 group by v3)
select id as v3 from title as t, aggView7310682628934212904 where t.id=aggView7310682628934212904.v3);
create or replace view aggJoin8641068545527515082 as (
with aggView8420294490697475085 as (select v3 from aggJoin1477575243388720998 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView8420294490697475085 where ci.movie_id=aggView8420294490697475085.v3);
create or replace view aggJoin7613869406374311368 as (
with aggView8054281449209786270 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView8054281449209786270 where mk.keyword_id=aggView8054281449209786270.v25);
create or replace view aggJoin2060427674450646470 as (
with aggView6348694828079822581 as (select v3 from aggJoin7613869406374311368 group by v3)
select v26 from aggJoin8641068545527515082 join aggView6348694828079822581 using(v3));
create or replace view aggJoin4373370708257339733 as (
with aggView8117210817664422709 as (select v26 from aggJoin2060427674450646470 group by v26)
select name as v27 from name as n, aggView8117210817664422709 where n.id=aggView8117210817664422709.v26 and name LIKE 'Z%');
create or replace view aggView1162709560713232800 as select v27 from aggJoin4373370708257339733 group by v27;
select MIN(v27) as v47 from aggView1162709560713232800;
