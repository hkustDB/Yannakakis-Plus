create or replace view aggJoin8171306078002260560 as (
with aggView8973280903406810520 as (select id as v53, title as v66 from title as t where production_year>=2005 and production_year<=2009)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView8973280903406810520 where ci.movie_id=aggView8973280903406810520.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin5565241185845366199 as (
with aggView3919529284627582725 as (select id as v42, name as v65 from name as n where name LIKE '%Ang%' and gender= 'f')
select person_id as v42, v65 from aka_name as an, aggView3919529284627582725 where an.person_id=aggView3919529284627582725.v42);
create or replace view aggJoin2061792617248227781 as (
with aggView2865223440667398667 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView2865223440667398667 where mc.company_id=aggView2865223440667398667.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin9126609085616548732 as (
with aggView6934687541181210816 as (select v42, MIN(v65) as v65 from aggJoin5565241185845366199 group by v42,v65)
select v53, v9, v20, v51, v66 as v66, v65 from aggJoin8171306078002260560 join aggView6934687541181210816 using(v42));
create or replace view aggJoin4418915973811768270 as (
with aggView6671493483812633166 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView6671493483812633166 where mi.info_type_id=aggView6671493483812633166.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin1611074670850871181 as (
with aggView7501602545974461576 as (select v53 from aggJoin4418915973811768270 group by v53)
select v53, v36 from aggJoin2061792617248227781 join aggView7501602545974461576 using(v53));
create or replace view aggJoin2462465567878897888 as (
with aggView8304745266270156203 as (select v53 from aggJoin1611074670850871181 group by v53)
select v9, v20, v51, v66 as v66, v65 as v65 from aggJoin9126609085616548732 join aggView8304745266270156203 using(v53));
create or replace view aggJoin4914708944340083742 as (
with aggView8736693560261162377 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v66, v65 from aggJoin2462465567878897888 join aggView8736693560261162377 using(v51));
create or replace view aggJoin3290879929185463982 as (
with aggView7087023038524281665 as (select v9, MIN(v66) as v66, MIN(v65) as v65 from aggJoin4914708944340083742 group by v9,v66,v65)
select v66, v65 from char_name as chn, aggView7087023038524281665 where chn.id=aggView7087023038524281665.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin3290879929185463982;
