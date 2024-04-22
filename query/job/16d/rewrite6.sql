create or replace view aggJoin9158550563243905339 as (
with aggView3720664477836662353 as (select id as v11, title as v56 from title as t where episode_nr>=5 and episode_nr<100)
select movie_id as v11, company_id as v28, v56 from movie_companies as mc, aggView3720664477836662353 where mc.movie_id=aggView3720664477836662353.v11);
create or replace view aggJoin3253788718874651780 as (
with aggView1513400513010302402 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select id as v2, v55 from name as n, aggView1513400513010302402 where n.id=aggView1513400513010302402.v2);
create or replace view aggJoin5231754171713202526 as (
with aggView5434670058592325596 as (select v2, MIN(v55) as v55 from aggJoin3253788718874651780 group by v2,v55)
select movie_id as v11, v55 from cast_info as ci, aggView5434670058592325596 where ci.person_id=aggView5434670058592325596.v2);
create or replace view aggJoin3275555682099064131 as (
with aggView336513845952501960 as (select id as v28 from company_name as cn where country_code= '[us]')
select v11, v56 from aggJoin9158550563243905339 join aggView336513845952501960 using(v28));
create or replace view aggJoin4766739589115387050 as (
with aggView8702521795994303459 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView8702521795994303459 where mk.keyword_id=aggView8702521795994303459.v33);
create or replace view aggJoin3354974204598435718 as (
with aggView7909854115776574258 as (select v11, MIN(v56) as v56 from aggJoin3275555682099064131 group by v11,v56)
select v11, v56 from aggJoin4766739589115387050 join aggView7909854115776574258 using(v11));
create or replace view aggJoin6450476804814267630 as (
with aggView1499787863939518607 as (select v11, MIN(v56) as v56 from aggJoin3354974204598435718 group by v11,v56)
select v55 as v55, v56 from aggJoin5231754171713202526 join aggView1499787863939518607 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin6450476804814267630;
