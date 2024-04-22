create or replace view aggJoin1753201649910380417 as (
with aggView5671366694995319429 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView5671366694995319429 where mk.keyword_id=aggView5671366694995319429.v33);
create or replace view aggJoin6522618805130352711 as (
with aggView8253032063836591366 as (select v11 from aggJoin1753201649910380417 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView8253032063836591366 where t.id=aggView8253032063836591366.v11 and episode_nr>=50 and episode_nr<100);
create or replace view aggView223487747135358616 as select v11, v44 from aggJoin6522618805130352711 group by v11,v44;
create or replace view aggJoin2887708488372072349 as (
with aggView9150331857255628551 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView9150331857255628551 where an.person_id=aggView9150331857255628551.v2);
create or replace view aggView311442871257433374 as select v2, v3 from aggJoin2887708488372072349 group by v2,v3;
create or replace view aggJoin8637078623366149033 as (
with aggView2462815494125099746 as (select v2, MIN(v3) as v55 from aggView311442871257433374 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView2462815494125099746 where ci.person_id=aggView2462815494125099746.v2);
create or replace view aggJoin5009060865922873789 as (
with aggView236799410502810631 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView236799410502810631 where mc.company_id=aggView236799410502810631.v28);
create or replace view aggJoin6036709560252451368 as (
with aggView4767804739624864479 as (select v11 from aggJoin5009060865922873789 group by v11)
select v11, v55 as v55 from aggJoin8637078623366149033 join aggView4767804739624864479 using(v11));
create or replace view aggJoin5589835784212326918 as (
with aggView2894129503415103929 as (select v11, MIN(v55) as v55 from aggJoin6036709560252451368 group by v11,v55)
select v44, v55 from aggView223487747135358616 join aggView2894129503415103929 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin5589835784212326918;
