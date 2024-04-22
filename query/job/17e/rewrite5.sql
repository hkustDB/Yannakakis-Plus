create or replace view aggJoin6082686530131753421 as (
with aggView9032673073778114327 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView9032673073778114327 where mc.company_id=aggView9032673073778114327.v20);
create or replace view aggJoin5563075364680564176 as (
with aggView7546570046101063108 as (select v3 from aggJoin6082686530131753421 group by v3)
select id as v3 from title as t, aggView7546570046101063108 where t.id=aggView7546570046101063108.v3);
create or replace view aggJoin2960111989896731287 as (
with aggView7444581154992916280 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView7444581154992916280 where mk.keyword_id=aggView7444581154992916280.v25);
create or replace view aggJoin2277242540336714291 as (
with aggView6402088203665955362 as (select v3 from aggJoin2960111989896731287 group by v3)
select v3 from aggJoin5563075364680564176 join aggView6402088203665955362 using(v3));
create or replace view aggJoin673985952242712382 as (
with aggView1785311157130261120 as (select v3 from aggJoin2277242540336714291 group by v3)
select person_id as v26 from cast_info as ci, aggView1785311157130261120 where ci.movie_id=aggView1785311157130261120.v3);
create or replace view aggJoin3310818141106165986 as (
with aggView1033897503582852742 as (select v26 from aggJoin673985952242712382 group by v26)
select name as v27 from name as n, aggView1033897503582852742 where n.id=aggView1033897503582852742.v26);
create or replace view aggView1708548334701336971 as select v27 from aggJoin3310818141106165986 group by v27;
select MIN(v27) as v47 from aggView1708548334701336971;
