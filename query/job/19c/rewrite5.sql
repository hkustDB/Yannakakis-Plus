create or replace view aggJoin2044057322550363769 as (
with aggView2810735160888694571 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView2810735160888694571 where mi.info_type_id=aggView2810735160888694571.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin4045391363566287570 as (
with aggView4156862064323000327 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView4156862064323000327 where n.id=aggView4156862064323000327.v42 and name LIKE '%An%' and gender= 'f');
create or replace view aggView9157952965657096598 as select v43, v42 from aggJoin4045391363566287570 group by v43,v42;
create or replace view aggJoin8481843992689827411 as (
with aggView3385251152572091384 as (select v53 from aggJoin2044057322550363769 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView3385251152572091384 where t.id=aggView3385251152572091384.v53 and production_year>2000);
create or replace view aggView7165897705441400766 as select v53, v54 from aggJoin8481843992689827411 group by v53,v54;
create or replace view aggJoin3021933822474498847 as (
with aggView5113587965597246970 as (select v42, MIN(v43) as v65 from aggView9157952965657096598 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView5113587965597246970 where ci.person_id=aggView5113587965597246970.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin3113618703031541752 as (
with aggView2873636484849536184 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v9, v20, v65 from aggJoin3021933822474498847 join aggView2873636484849536184 using(v51));
create or replace view aggJoin8997780491964456692 as (
with aggView136337112506879417 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView136337112506879417 where mc.company_id=aggView136337112506879417.v23);
create or replace view aggJoin5413105974926495559 as (
with aggView1973002765512155319 as (select id as v9 from char_name as chn)
select v53, v20, v65 from aggJoin3113618703031541752 join aggView1973002765512155319 using(v9));
create or replace view aggJoin3378852185180278636 as (
with aggView1217388241325595639 as (select v53 from aggJoin8997780491964456692 group by v53)
select v53, v20, v65 as v65 from aggJoin5413105974926495559 join aggView1217388241325595639 using(v53));
create or replace view aggJoin528496479613712509 as (
with aggView4403993585110951635 as (select v53, MIN(v65) as v65 from aggJoin3378852185180278636 group by v53,v65)
select v54, v65 from aggView7165897705441400766 join aggView4403993585110951635 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin528496479613712509;
