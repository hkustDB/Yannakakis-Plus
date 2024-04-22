create or replace view aggView1464591123913345586 as select person_id as v2, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView8532043036145543807 as select title as v44, id as v11 from title as t where episode_nr<100;
create or replace view aggJoin7713515009957696697 as (
with aggView5542914368711364363 as (select v2, MIN(v3) as v55 from aggView1464591123913345586 group by v2)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView5542914368711364363 where ci.person_id=aggView5542914368711364363.v2);
create or replace view aggJoin6785914083160625909 as (
with aggView7952015544730380985 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView7952015544730380985 where mk.keyword_id=aggView7952015544730380985.v33);
create or replace view aggJoin760390888244065714 as (
with aggView7842920668820615113 as (select v11 from aggJoin6785914083160625909 group by v11)
select movie_id as v11, company_id as v28 from movie_companies as mc, aggView7842920668820615113 where mc.movie_id=aggView7842920668820615113.v11);
create or replace view aggJoin1813492504267870173 as (
with aggView6038423996044279733 as (select id as v28 from company_name as cn where country_code= '[us]')
select v11 from aggJoin760390888244065714 join aggView6038423996044279733 using(v28));
create or replace view aggJoin6453661480914509260 as (
with aggView1490254082877589942 as (select v11 from aggJoin1813492504267870173 group by v11)
select v2, v11, v55 as v55 from aggJoin7713515009957696697 join aggView1490254082877589942 using(v11));
create or replace view aggJoin106589278351050711 as (
with aggView479599301873677152 as (select id as v2 from name as n)
select v11, v55 from aggJoin6453661480914509260 join aggView479599301873677152 using(v2));
create or replace view aggJoin8500571681712946842 as (
with aggView1834992183290672576 as (select v11, MIN(v55) as v55 from aggJoin106589278351050711 group by v11,v55)
select v44, v55 from aggView8532043036145543807 join aggView1834992183290672576 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin8500571681712946842;
