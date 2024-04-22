create or replace view aggView231965810383709847 as select name as v3, person_id as v2 from aka_name as an group by name,person_id;
create or replace view aggJoin2767934808816661835 as (
with aggView823281643674084710 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView823281643674084710 where mk.keyword_id=aggView823281643674084710.v33);
create or replace view aggJoin8684537084140508040 as (
with aggView5914963363001822503 as (select v11 from aggJoin2767934808816661835 group by v11)
select id as v11, title as v44 from title as t, aggView5914963363001822503 where t.id=aggView5914963363001822503.v11);
create or replace view aggView4429933536933113642 as select v44, v11 from aggJoin8684537084140508040 group by v44,v11;
create or replace view aggJoin1564446841205816662 as (
with aggView7585436659897953453 as (select v2, MIN(v3) as v55 from aggView231965810383709847 group by v2)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView7585436659897953453 where ci.person_id=aggView7585436659897953453.v2);
create or replace view aggJoin3166774008141323762 as (
with aggView6992013482095679766 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView6992013482095679766 where mc.company_id=aggView6992013482095679766.v28);
create or replace view aggJoin4708817611615241451 as (
with aggView4635501154390667939 as (select id as v2 from name as n)
select v11, v55 from aggJoin1564446841205816662 join aggView4635501154390667939 using(v2));
create or replace view aggJoin246714804269630228 as (
with aggView2434634928144860827 as (select v11 from aggJoin3166774008141323762 group by v11)
select v11, v55 as v55 from aggJoin4708817611615241451 join aggView2434634928144860827 using(v11));
create or replace view aggJoin1684705552566937311 as (
with aggView3509107213549690615 as (select v11, MIN(v55) as v55 from aggJoin246714804269630228 group by v11,v55)
select v44, v55 from aggView4429933536933113642 join aggView3509107213549690615 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin1684705552566937311;
