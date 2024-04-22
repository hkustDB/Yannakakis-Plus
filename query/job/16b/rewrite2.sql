create or replace view aggJoin6378414645107232806 as (
with aggView3931515259828246390 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView3931515259828246390 where an.person_id=aggView3931515259828246390.v2);
create or replace view aggView1672157643430266934 as select v3, v2 from aggJoin6378414645107232806 group by v3,v2;
create or replace view aggJoin5728635392224949587 as (
with aggView3749949444610780455 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView3749949444610780455 where mk.keyword_id=aggView3749949444610780455.v33);
create or replace view aggJoin6704088116768428833 as (
with aggView638734370494624919 as (select v11 from aggJoin5728635392224949587 group by v11)
select id as v11, title as v44 from title as t, aggView638734370494624919 where t.id=aggView638734370494624919.v11);
create or replace view aggView7921340227397563765 as select v44, v11 from aggJoin6704088116768428833 group by v44,v11;
create or replace view aggJoin2964038509451301244 as (
with aggView6630608678871716413 as (select v2, MIN(v3) as v55 from aggView1672157643430266934 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView6630608678871716413 where ci.person_id=aggView6630608678871716413.v2);
create or replace view aggJoin736268459154207332 as (
with aggView7750552991288854941 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView7750552991288854941 where mc.company_id=aggView7750552991288854941.v28);
create or replace view aggJoin8998004818797998336 as (
with aggView1657494578714591645 as (select v11 from aggJoin736268459154207332 group by v11)
select v11, v55 as v55 from aggJoin2964038509451301244 join aggView1657494578714591645 using(v11));
create or replace view aggJoin4187748589758038431 as (
with aggView8053461557279603597 as (select v11, MIN(v55) as v55 from aggJoin8998004818797998336 group by v11,v55)
select v44, v55 from aggView7921340227397563765 join aggView8053461557279603597 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin4187748589758038431;
