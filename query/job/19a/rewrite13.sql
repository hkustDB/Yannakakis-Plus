create or replace view aggJoin5995153628693393374 as (
with aggView6933862429794557225 as (select id as v42, name as v65 from name as n where name LIKE '%Ang%' and gender= 'f')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView6933862429794557225 where ci.person_id=aggView6933862429794557225.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin7057082551901611960 as (
with aggView5839831412597963786 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView5839831412597963786 where mc.company_id=aggView5839831412597963786.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin7158178501035883388 as (
with aggView2053642119833470162 as (select person_id as v42 from aka_name as an group by person_id)
select v53, v9, v20, v51, v65 as v65 from aggJoin5995153628693393374 join aggView2053642119833470162 using(v42));
create or replace view aggJoin2605735640333554687 as (
with aggView1460492416788330098 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView1460492416788330098 where mi.info_type_id=aggView1460492416788330098.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin6088246878307473337 as (
with aggView522600013035377811 as (select v53 from aggJoin2605735640333554687 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView522600013035377811 where t.id=aggView522600013035377811.v53 and production_year>=2005 and production_year<=2009);
create or replace view aggJoin8240192879608155941 as (
with aggView1805842256061205355 as (select v53, MIN(v54) as v66 from aggJoin6088246878307473337 group by v53)
select v53, v36, v66 from aggJoin7057082551901611960 join aggView1805842256061205355 using(v53));
create or replace view aggJoin3664632893747955801 as (
with aggView21755578275362232 as (select v53, MIN(v66) as v66 from aggJoin8240192879608155941 group by v53,v66)
select v9, v20, v51, v65 as v65, v66 from aggJoin7158178501035883388 join aggView21755578275362232 using(v53));
create or replace view aggJoin9159943337517585423 as (
with aggView7891384340020151369 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v65, v66 from aggJoin3664632893747955801 join aggView7891384340020151369 using(v51));
create or replace view aggJoin5696799627149100177 as (
with aggView2798111805164579197 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin9159943337517585423 group by v9,v66,v65)
select v65, v66 from char_name as chn, aggView2798111805164579197 where chn.id=aggView2798111805164579197.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin5696799627149100177;
