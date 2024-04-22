create or replace view aggView6000494277140838603 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]';
create or replace view aggJoin4744999377556017630 as (
with aggView6485472196959270617 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView6485472196959270617 where mk.keyword_id=aggView6485472196959270617.v22);
create or replace view aggJoin7441380041080242948 as (
with aggView7900833476121213820 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView7900833476121213820 where mc.company_type_id=aggView7900833476121213820.v18);
create or replace view aggView6469749766953027546 as select v19, v24, v17 from aggJoin7441380041080242948 group by v19,v24,v17;
create or replace view aggJoin3281657877087782267 as (
with aggView3096846482436091731 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView3096846482436091731 where ml.link_type_id=aggView3096846482436091731.v13);
create or replace view aggJoin7092660939511164396 as (
with aggView7859693111707808065 as (select v24 from aggJoin3281657877087782267 group by v24)
select v24 from aggJoin4744999377556017630 join aggView7859693111707808065 using(v24));
create or replace view aggJoin5975673899120970043 as (
with aggView8820529434790031556 as (select v24 from aggJoin7092660939511164396 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView8820529434790031556 where t.id=aggView8820529434790031556.v24 and production_year>1950);
create or replace view aggView6367085482693578580 as select v24, v28 from aggJoin5975673899120970043 group by v24,v28;
create or replace view aggJoin4185947224129488536 as (
with aggView2604467155794842189 as (select v17, MIN(v2) as v39 from aggView6000494277140838603 group by v17)
select v19, v24, v39 from aggView6469749766953027546 join aggView2604467155794842189 using(v17));
create or replace view aggJoin5560660540531692832 as (
with aggView2765208683732471773 as (select v24, MIN(v28) as v41 from aggView6367085482693578580 group by v24)
select v19, v39 as v39, v41 from aggJoin4185947224129488536 join aggView2765208683732471773 using(v24));
select MIN(v39) as v39,MIN(v19) as v40,MIN(v41) as v41 from aggJoin5560660540531692832;
