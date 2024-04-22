create or replace view aggJoin5822539448475670040 as (
with aggView5337285503122520105 as (select id as v42, name as v43 from name as n where gender= 'f')
select v42, v43 from aggView5337285503122520105 where v43 LIKE '%Angel%');
create or replace view aggJoin3085846419418672386 as (
with aggView587606877897092187 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView587606877897092187 where mi.info_type_id=aggView587606877897092187.v30 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin2267972983453786966 as (
with aggView3910601745421155113 as (select v53 from aggJoin3085846419418672386 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView3910601745421155113 where t.id=aggView3910601745421155113.v53 and production_year>=2007 and production_year<=2008);
create or replace view aggJoin6947715685205379275 as (
with aggView8170253200843504735 as (select v54, v53 from aggJoin2267972983453786966 group by v54,v53)
select v53, v54 from aggView8170253200843504735 where v54 LIKE '%Kung%Fu%Panda%');
create or replace view aggJoin3052449019781614542 as (
with aggView8310893914817053694 as (select v53, MIN(v54) as v66 from aggJoin6947715685205379275 group by v53)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView8310893914817053694 where ci.movie_id=aggView8310893914817053694.v53 and note= '(voice)');
create or replace view aggJoin2843637430013262066 as (
with aggView2215654497109626063 as (select person_id as v42 from aka_name as an group by person_id)
select v42, v53, v9, v20, v51, v66 as v66 from aggJoin3052449019781614542 join aggView2215654497109626063 using(v42));
create or replace view aggJoin2308499183011273741 as (
with aggView7055550761069049773 as (select id as v9 from char_name as chn)
select v42, v53, v20, v51, v66 from aggJoin2843637430013262066 join aggView7055550761069049773 using(v9));
create or replace view aggJoin7503138084976282305 as (
with aggView8572267990693508126 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v53, v20, v66 from aggJoin2308499183011273741 join aggView8572267990693508126 using(v51));
create or replace view aggJoin7478310469642752728 as (
with aggView6777380004111957514 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView6777380004111957514 where mc.company_id=aggView6777380004111957514.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin8580853336312926398 as (
with aggView6462634745010633719 as (select v53 from aggJoin7478310469642752728 group by v53)
select v42, v20, v66 as v66 from aggJoin7503138084976282305 join aggView6462634745010633719 using(v53));
create or replace view aggJoin8428250051606033962 as (
with aggView8670268651392540352 as (select v42, MIN(v66) as v66 from aggJoin8580853336312926398 group by v42,v66)
select v43, v66 from aggJoin5822539448475670040 join aggView8670268651392540352 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin8428250051606033962;
