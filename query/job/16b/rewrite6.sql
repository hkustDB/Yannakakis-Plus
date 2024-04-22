create or replace view aggJoin6345282383434097692 as (
with aggView8088047828139325177 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select id as v2, v55 from name as n, aggView8088047828139325177 where n.id=aggView8088047828139325177.v2);
create or replace view aggJoin2316909394282124895 as (
with aggView5151800008178735614 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView5151800008178735614 where mk.keyword_id=aggView5151800008178735614.v33);
create or replace view aggJoin6301361460164853741 as (
with aggView4321527409885001870 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView4321527409885001870 where mc.company_id=aggView4321527409885001870.v28);
create or replace view aggJoin7356840202653564153 as (
with aggView1596186072881861019 as (select v2, MIN(v55) as v55 from aggJoin6345282383434097692 group by v2,v55)
select movie_id as v11, v55 from cast_info as ci, aggView1596186072881861019 where ci.person_id=aggView1596186072881861019.v2);
create or replace view aggJoin4705914971970256288 as (
with aggView1649527278373212720 as (select v11 from aggJoin2316909394282124895 group by v11)
select v11 from aggJoin6301361460164853741 join aggView1649527278373212720 using(v11));
create or replace view aggJoin8654748372091432049 as (
with aggView519158731633547304 as (select v11 from aggJoin4705914971970256288 group by v11)
select id as v11, title as v44 from title as t, aggView519158731633547304 where t.id=aggView519158731633547304.v11);
create or replace view aggJoin7301335378323974643 as (
with aggView7001597342534847263 as (select v11, MIN(v44) as v56 from aggJoin8654748372091432049 group by v11)
select v55 as v55, v56 from aggJoin7356840202653564153 join aggView7001597342534847263 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin7301335378323974643;
