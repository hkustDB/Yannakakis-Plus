create or replace view aggJoin8121163613059164483 as (
with aggView4913675922290278931 as (select id as v3 from title as t)
select movie_id as v3, company_id as v20 from movie_companies as mc, aggView4913675922290278931 where mc.movie_id=aggView4913675922290278931.v3);
create or replace view aggJoin1218753221741499729 as (
with aggView9218650230572033575 as (select id as v20 from company_name as cn where country_code= '[us]')
select v3 from aggJoin8121163613059164483 join aggView9218650230572033575 using(v20));
create or replace view aggJoin8707912191994661661 as (
with aggView7627346567728049576 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView7627346567728049576 where mk.keyword_id=aggView7627346567728049576.v25);
create or replace view aggJoin3787567566580824051 as (
with aggView5527559788640827207 as (select v3 from aggJoin8707912191994661661 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView5527559788640827207 where ci.movie_id=aggView5527559788640827207.v3);
create or replace view aggJoin8684691003623563369 as (
with aggView755433867375115467 as (select v3 from aggJoin1218753221741499729 group by v3)
select v26 from aggJoin3787567566580824051 join aggView755433867375115467 using(v3));
create or replace view aggJoin4448199085245813282 as (
with aggView1894549220721782050 as (select v26 from aggJoin8684691003623563369 group by v26)
select name as v27 from name as n, aggView1894549220721782050 where n.id=aggView1894549220721782050.v26);
create or replace view aggView5945498979850931930 as select v27 from aggJoin4448199085245813282 group by v27;
select MIN(v27) as v47 from aggView5945498979850931930;
