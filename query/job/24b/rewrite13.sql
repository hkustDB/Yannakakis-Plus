create or replace view aggJoin6825062909122335495 as (
with aggView94850960779654166 as (select id as v59, title as v60 from title as t where production_year>2010)
select v59, v60 from aggView94850960779654166 where v60 LIKE 'Kung Fu Panda%');
create or replace view aggView7458481676034231354 as select name as v49, id as v48 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggView6985598963835336693 as select id as v9, name as v10 from char_name as chn;
create or replace view aggJoin7192336418118101109 as (
with aggView4105123366857821914 as (select v48, MIN(v49) as v72 from aggView7458481676034231354 group by v48)
select person_id as v48, movie_id as v59, person_role_id as v9, note as v20, role_id as v57, v72 from cast_info as ci, aggView4105123366857821914 where ci.person_id=aggView4105123366857821914.v48 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin354459084311182986 as (
with aggView112425850948851651 as (select v59, MIN(v60) as v73 from aggJoin6825062909122335495 group by v59)
select v48, v59, v9, v20, v57, v72 as v72, v73 from aggJoin7192336418118101109 join aggView112425850948851651 using(v59));
create or replace view aggJoin7777983391492733273 as (
with aggView7319718341919242723 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v59, v9, v20, v72, v73 from aggJoin354459084311182986 join aggView7319718341919242723 using(v57));
create or replace view aggJoin5172604527150565039 as (
with aggView6414681672068203508 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView6414681672068203508 where mi.info_type_id=aggView6414681672068203508.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin5898208423300501274 as (
with aggView1935490555325459502 as (select person_id as v48 from aka_name as an group by person_id)
select v59, v9, v20, v72 as v72, v73 as v73 from aggJoin7777983391492733273 join aggView1935490555325459502 using(v48));
create or replace view aggJoin6587223831666022437 as (
with aggView938632187841638632 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select movie_id as v59 from movie_keyword as mk, aggView938632187841638632 where mk.keyword_id=aggView938632187841638632.v32);
create or replace view aggJoin6139970621098020621 as (
with aggView3368817293672714713 as (select v59 from aggJoin5172604527150565039 group by v59)
select movie_id as v59, company_id as v23 from movie_companies as mc, aggView3368817293672714713 where mc.movie_id=aggView3368817293672714713.v59);
create or replace view aggJoin1680328118347074575 as (
with aggView1905635411733597234 as (select v59 from aggJoin6587223831666022437 group by v59)
select v59, v23 from aggJoin6139970621098020621 join aggView1905635411733597234 using(v59));
create or replace view aggJoin5619321389483015755 as (
with aggView7565251165356699947 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select v59 from aggJoin1680328118347074575 join aggView7565251165356699947 using(v23));
create or replace view aggJoin6712419747548020533 as (
with aggView4706725977521952920 as (select v59 from aggJoin5619321389483015755 group by v59)
select v9, v20, v72 as v72, v73 as v73 from aggJoin5898208423300501274 join aggView4706725977521952920 using(v59));
create or replace view aggJoin8412962968079793731 as (
with aggView8017746773200192350 as (select v9, MIN(v72) as v72, MIN(v73) as v73 from aggJoin6712419747548020533 group by v9,v72,v73)
select v10, v72, v73 from aggView6985598963835336693 join aggView8017746773200192350 using(v9));
select MIN(v10) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin8412962968079793731;
