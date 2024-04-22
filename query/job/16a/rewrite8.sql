create or replace view aggJoin3330313958458208707 as (
with aggView717332165765140027 as (select id as v11, title as v56 from title as t where episode_nr>=50 and episode_nr<100)
select movie_id as v11, company_id as v28, v56 from movie_companies as mc, aggView717332165765140027 where mc.movie_id=aggView717332165765140027.v11);
create or replace view aggJoin6668891297484506151 as (
with aggView8344862907670120714 as (select id as v28 from company_name as cn where country_code= '[us]')
select v11, v56 from aggJoin3330313958458208707 join aggView8344862907670120714 using(v28));
create or replace view aggJoin2487021212963828163 as (
with aggView8048972749469226554 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView8048972749469226554 where mk.keyword_id=aggView8048972749469226554.v33);
create or replace view aggJoin6196717637877684202 as (
with aggView6193905906904870733 as (select v11, MIN(v56) as v56 from aggJoin6668891297484506151 group by v11,v56)
select v11, v56 from aggJoin2487021212963828163 join aggView6193905906904870733 using(v11));
create or replace view aggJoin8595322899161296906 as (
with aggView6019444097387906139 as (select v11, MIN(v56) as v56 from aggJoin6196717637877684202 group by v11,v56)
select person_id as v2, v56 from cast_info as ci, aggView6019444097387906139 where ci.movie_id=aggView6019444097387906139.v11);
create or replace view aggJoin6726990802320083880 as (
with aggView7037684020905070175 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView7037684020905070175 where an.person_id=aggView7037684020905070175.v2);
create or replace view aggJoin7613050886540305842 as (
with aggView7819765226321872366 as (select v2, MIN(v3) as v55 from aggJoin6726990802320083880 group by v2)
select v56 as v56, v55 from aggJoin8595322899161296906 join aggView7819765226321872366 using(v2));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin7613050886540305842;
