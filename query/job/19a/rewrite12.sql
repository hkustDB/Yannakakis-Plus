create or replace view aggJoin6621804388456502362 as (
with aggView5745976415413025663 as (select id as v53, title as v66 from title as t where production_year>=2005 and production_year<=2009)
select movie_id as v53, company_id as v23, note as v36, v66 from movie_companies as mc, aggView5745976415413025663 where mc.movie_id=aggView5745976415413025663.v53 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin5548165001025378682 as (
with aggView9017029042749822727 as (select id as v42, name as v65 from name as n where name LIKE '%Ang%' and gender= 'f')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView9017029042749822727 where ci.person_id=aggView9017029042749822727.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin2522373084451727636 as (
with aggView7655820357524512131 as (select id as v23 from company_name as cn where country_code= '[us]')
select v53, v36, v66 from aggJoin6621804388456502362 join aggView7655820357524512131 using(v23));
create or replace view aggJoin5901199145002328929 as (
with aggView4991786774082367746 as (select person_id as v42 from aka_name as an group by person_id)
select v53, v9, v20, v51, v65 as v65 from aggJoin5548165001025378682 join aggView4991786774082367746 using(v42));
create or replace view aggJoin4753976156440405368 as (
with aggView2194511958646290617 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView2194511958646290617 where mi.info_type_id=aggView2194511958646290617.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin2504729174873201609 as (
with aggView2285383010295018080 as (select v53 from aggJoin4753976156440405368 group by v53)
select v53, v36, v66 as v66 from aggJoin2522373084451727636 join aggView2285383010295018080 using(v53));
create or replace view aggJoin9126534572610252095 as (
with aggView4039787935892490330 as (select v53, MIN(v66) as v66 from aggJoin2504729174873201609 group by v53,v66)
select v9, v20, v51, v65 as v65, v66 from aggJoin5901199145002328929 join aggView4039787935892490330 using(v53));
create or replace view aggJoin8466567882277038421 as (
with aggView959464271637972761 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v65, v66 from aggJoin9126534572610252095 join aggView959464271637972761 using(v51));
create or replace view aggJoin877290067113629114 as (
with aggView4347079604490440156 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin8466567882277038421 group by v9,v66,v65)
select v65, v66 from char_name as chn, aggView4347079604490440156 where chn.id=aggView4347079604490440156.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin877290067113629114;
