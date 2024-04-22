create or replace view aggJoin5697682201427518680 as (
with aggView7492016472282305380 as (select id as v53, title as v66 from title as t where production_year>=2005 and production_year<=2009)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView7492016472282305380 where ci.movie_id=aggView7492016472282305380.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin8770177260559121540 as (
with aggView5147318216424007916 as (select id as v42, name as v65 from name as n where name LIKE '%Ang%' and gender= 'f')
select person_id as v42, v65 from aka_name as an, aggView5147318216424007916 where an.person_id=aggView5147318216424007916.v42);
create or replace view aggJoin113480747752485966 as (
with aggView5092623404032427696 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView5092623404032427696 where mc.company_id=aggView5092623404032427696.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin5170466848983937213 as (
with aggView1572217266535020035 as (select v53 from aggJoin113480747752485966 group by v53)
select v42, v53, v9, v20, v51, v66 as v66 from aggJoin5697682201427518680 join aggView1572217266535020035 using(v53));
create or replace view aggJoin2129326645662265881 as (
with aggView2727235268270975613 as (select v42, MIN(v65) as v65 from aggJoin8770177260559121540 group by v42,v65)
select v53, v9, v20, v51, v66 as v66, v65 from aggJoin5170466848983937213 join aggView2727235268270975613 using(v42));
create or replace view aggJoin2230451813020507135 as (
with aggView4596975670535582152 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView4596975670535582152 where mi.info_type_id=aggView4596975670535582152.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin5343589616972133834 as (
with aggView1295462480032611831 as (select v53 from aggJoin2230451813020507135 group by v53)
select v9, v20, v51, v66 as v66, v65 as v65 from aggJoin2129326645662265881 join aggView1295462480032611831 using(v53));
create or replace view aggJoin5265543467278928093 as (
with aggView6417638753463050976 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v66, v65 from aggJoin5343589616972133834 join aggView6417638753463050976 using(v51));
create or replace view aggJoin7601333351866577286 as (
with aggView4808011453044720300 as (select v9, MIN(v66) as v66, MIN(v65) as v65 from aggJoin5265543467278928093 group by v9,v66,v65)
select v66, v65 from char_name as chn, aggView4808011453044720300 where chn.id=aggView4808011453044720300.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin7601333351866577286;
