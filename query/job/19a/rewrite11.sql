create or replace view aggJoin3792014184844551635 as (
with aggView5392650276495327390 as (select id as v53, title as v66 from title as t where production_year>=2005 and production_year<=2009)
select movie_id as v53, info_type_id as v30, info as v40, v66 from movie_info as mi, aggView5392650276495327390 where mi.movie_id=aggView5392650276495327390.v53 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin937247291539600068 as (
with aggView7029116995243700175 as (select id as v42, name as v65 from name as n where name LIKE '%Ang%' and gender= 'f')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView7029116995243700175 where ci.person_id=aggView7029116995243700175.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin8577409253404732907 as (
with aggView5667996839592590459 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView5667996839592590459 where mc.company_id=aggView5667996839592590459.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin3330269279947228070 as (
with aggView8896818452305170535 as (select v53 from aggJoin8577409253404732907 group by v53)
select v53, v30, v40, v66 as v66 from aggJoin3792014184844551635 join aggView8896818452305170535 using(v53));
create or replace view aggJoin4181669723406379923 as (
with aggView8334480985033809936 as (select person_id as v42 from aka_name as an group by person_id)
select v53, v9, v20, v51, v65 as v65 from aggJoin937247291539600068 join aggView8334480985033809936 using(v42));
create or replace view aggJoin9015147768460136279 as (
with aggView1381367830117766964 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40, v66 from aggJoin3330269279947228070 join aggView1381367830117766964 using(v30));
create or replace view aggJoin5502021239853486185 as (
with aggView846370073208263525 as (select v53, MIN(v66) as v66 from aggJoin9015147768460136279 group by v53,v66)
select v9, v20, v51, v65 as v65, v66 from aggJoin4181669723406379923 join aggView846370073208263525 using(v53));
create or replace view aggJoin1699025649885376798 as (
with aggView2601492069545849928 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v65, v66 from aggJoin5502021239853486185 join aggView2601492069545849928 using(v51));
create or replace view aggJoin2853397587333487363 as (
with aggView1952036259120417201 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin1699025649885376798 group by v9,v66,v65)
select v65, v66 from char_name as chn, aggView1952036259120417201 where chn.id=aggView1952036259120417201.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin2853397587333487363;
