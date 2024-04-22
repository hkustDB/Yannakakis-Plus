create or replace view aggJoin8734370893996799411 as (
with aggView3854508374623162429 as (select title as v54, id as v53 from title as t where production_year>=2007 and production_year<=2008)
select v53, v54 from aggView3854508374623162429 where v54 LIKE '%Kung%Fu%Panda%');
create or replace view aggJoin7947480608485721954 as (
with aggView4184067502214799360 as (select id as v42, name as v43 from name as n where gender= 'f')
select v42, v43 from aggView4184067502214799360 where v43 LIKE '%Angel%');
create or replace view aggJoin5224905996741345146 as (
with aggView6428468999621048445 as (select v42, MIN(v43) as v65 from aggJoin7947480608485721954 group by v42)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView6428468999621048445 where ci.person_id=aggView6428468999621048445.v42 and note= '(voice)');
create or replace view aggJoin2957208595918427112 as (
with aggView8165125070983050257 as (select person_id as v42 from aka_name as an group by person_id)
select v53, v9, v20, v51, v65 as v65 from aggJoin5224905996741345146 join aggView8165125070983050257 using(v42));
create or replace view aggJoin4413633908717750218 as (
with aggView3180822064432577637 as (select id as v9 from char_name as chn)
select v53, v20, v51, v65 from aggJoin2957208595918427112 join aggView3180822064432577637 using(v9));
create or replace view aggJoin2988644920403030276 as (
with aggView253839626258730322 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v20, v65 from aggJoin4413633908717750218 join aggView253839626258730322 using(v51));
create or replace view aggJoin8747017975223194901 as (
with aggView2012203730379496877 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView2012203730379496877 where mc.company_id=aggView2012203730379496877.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin2565611465560090821 as (
with aggView5231793740042246860 as (select v53 from aggJoin8747017975223194901 group by v53)
select movie_id as v53, info_type_id as v30, info as v40 from movie_info as mi, aggView5231793740042246860 where mi.movie_id=aggView5231793740042246860.v53 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin2542762386754392739 as (
with aggView8105268881571255603 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40 from aggJoin2565611465560090821 join aggView8105268881571255603 using(v30));
create or replace view aggJoin2280033098518827464 as (
with aggView940325874750366859 as (select v53 from aggJoin2542762386754392739 group by v53)
select v53, v20, v65 as v65 from aggJoin2988644920403030276 join aggView940325874750366859 using(v53));
create or replace view aggJoin2270093301036465526 as (
with aggView7001333533601645576 as (select v53, MIN(v65) as v65 from aggJoin2280033098518827464 group by v53,v65)
select v54, v65 from aggJoin8734370893996799411 join aggView7001333533601645576 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin2270093301036465526;
