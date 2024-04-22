create or replace view aggJoin8252514106292981678 as (
with aggView4682276097356624793 as (select id as v9, name as v71 from char_name as chn)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView4682276097356624793 where ci.person_role_id=aggView4682276097356624793.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin3393838337321335849 as (
with aggView5392397478272206555 as (select id as v59, title as v73 from title as t where title LIKE 'Kung Fu Panda%' and production_year>2010)
select v48, v59, v20, v57, v71, v73 from aggJoin8252514106292981678 join aggView5392397478272206555 using(v59));
create or replace view aggJoin148334477255534429 as (
with aggView5964233893309979953 as (select id as v48, name as v72 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v48, v72 from aka_name as an, aggView5964233893309979953 where an.person_id=aggView5964233893309979953.v48);
create or replace view aggJoin869359096913940972 as (
with aggView7709022839131796166 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v59, v20, v71, v73 from aggJoin3393838337321335849 join aggView7709022839131796166 using(v57));
create or replace view aggJoin5030813475563921218 as (
with aggView8659415571231684484 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView8659415571231684484 where mi.info_type_id=aggView8659415571231684484.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin1556344062735127386 as (
with aggView354434537786300062 as (select v48, MIN(v72) as v72 from aggJoin148334477255534429 group by v48,v72)
select v59, v20, v71 as v71, v73 as v73, v72 from aggJoin869359096913940972 join aggView354434537786300062 using(v48));
create or replace view aggJoin7719384913253185841 as (
with aggView8682095377460002722 as (select v59, MIN(v71) as v71, MIN(v73) as v73, MIN(v72) as v72 from aggJoin1556344062735127386 group by v59,v72,v71,v73)
select movie_id as v59, company_id as v23, v71, v73, v72 from movie_companies as mc, aggView8682095377460002722 where mc.movie_id=aggView8682095377460002722.v59);
create or replace view aggJoin6347007269156328277 as (
with aggView5173624074594209526 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select movie_id as v59 from movie_keyword as mk, aggView5173624074594209526 where mk.keyword_id=aggView5173624074594209526.v32);
create or replace view aggJoin6981067518465839371 as (
with aggView2158472158299482358 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select v59, v71, v73, v72 from aggJoin7719384913253185841 join aggView2158472158299482358 using(v23));
create or replace view aggJoin6195721061968328047 as (
with aggView7095581894921890456 as (select v59, MIN(v71) as v71, MIN(v73) as v73, MIN(v72) as v72 from aggJoin6981067518465839371 group by v59,v72,v71,v73)
select v59, v43, v71, v73, v72 from aggJoin5030813475563921218 join aggView7095581894921890456 using(v59));
create or replace view aggJoin2111904198227075935 as (
with aggView3925914866478085185 as (select v59, MIN(v71) as v71, MIN(v73) as v73, MIN(v72) as v72 from aggJoin6195721061968328047 group by v59,v72,v71,v73)
select v71, v73, v72 from aggJoin6347007269156328277 join aggView3925914866478085185 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin2111904198227075935;
