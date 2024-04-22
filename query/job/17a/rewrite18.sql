create or replace view aggJoin5865263018512128167 as (
with aggView4794937851089863098 as (select id as v26, name as v47 from name as n where name LIKE 'B%')
select movie_id as v3, v47 from cast_info as ci, aggView4794937851089863098 where ci.person_id=aggView4794937851089863098.v26);
create or replace view aggJoin8102300141884578592 as (
with aggView4903409250444600987 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView4903409250444600987 where mc.company_id=aggView4903409250444600987.v20);
create or replace view aggJoin7347885363776874284 as (
with aggView3867588591390204325 as (select id as v3 from title as t)
select v3, v47 from aggJoin5865263018512128167 join aggView3867588591390204325 using(v3));
create or replace view aggJoin52031176829541296 as (
with aggView2333154062052248478 as (select v3 from aggJoin8102300141884578592 group by v3)
select movie_id as v3, keyword_id as v25 from movie_keyword as mk, aggView2333154062052248478 where mk.movie_id=aggView2333154062052248478.v3);
create or replace view aggJoin9172620826000714162 as (
with aggView4988645599500718023 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select v3 from aggJoin52031176829541296 join aggView4988645599500718023 using(v25));
create or replace view aggJoin3559898030664373144 as (
with aggView103546193985421471 as (select v3 from aggJoin9172620826000714162 group by v3)
select v47 as v47 from aggJoin7347885363776874284 join aggView103546193985421471 using(v3));
select MIN(v47) as v47 from aggJoin3559898030664373144;
