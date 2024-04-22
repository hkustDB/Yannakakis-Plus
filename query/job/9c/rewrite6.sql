create or replace view aggJoin4649829501505078595 as (
with aggView2238279138212134753 as (select id as v9, name as v59 from char_name as chn)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView2238279138212134753 where ci.person_role_id=aggView2238279138212134753.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin2402746373673268113 as (
with aggView7329003294407308482 as (select person_id as v35, MIN(name) as v58 from aka_name as an group by person_id)
select id as v35, name as v36, gender as v39, v58 from name as n, aggView7329003294407308482 where n.id=aggView7329003294407308482.v35 and name LIKE '%An%' and gender= 'f');
create or replace view aggJoin4672102094851340796 as (
with aggView7002866781115967934 as (select v35, MIN(v58) as v58, MIN(v36) as v60 from aggJoin2402746373673268113 group by v35,v58)
select v18, v20, v22, v59 as v59, v58, v60 from aggJoin4649829501505078595 join aggView7002866781115967934 using(v35));
create or replace view aggJoin8663530300865590602 as (
with aggView6815060651649103576 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v59, v58, v60 from aggJoin4672102094851340796 join aggView6815060651649103576 using(v22));
create or replace view aggJoin5296983261290291604 as (
with aggView7207589578897114886 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView7207589578897114886 where mc.company_id=aggView7207589578897114886.v32);
create or replace view aggJoin6430576308747686328 as (
with aggView3734301126202316968 as (select v18 from aggJoin5296983261290291604 group by v18)
select id as v18, title as v47 from title as t, aggView3734301126202316968 where t.id=aggView3734301126202316968.v18);
create or replace view aggJoin6552305775678002190 as (
with aggView5217007543193415160 as (select v18, MIN(v59) as v59, MIN(v58) as v58, MIN(v60) as v60 from aggJoin8663530300865590602 group by v18,v58,v60,v59)
select v47, v59, v58, v60 from aggJoin6430576308747686328 join aggView5217007543193415160 using(v18));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v47) as v61 from aggJoin6552305775678002190;
