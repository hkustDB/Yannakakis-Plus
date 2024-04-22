create or replace view aggView4312097061521534939 as select id as v18, title as v47 from title as t;
create or replace view aggView3407765237469235083 as select name as v10, id as v9 from char_name as chn;
create or replace view aggView6431022756426713828 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView1960973902539518658 as select name as v36, id as v35 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggJoin8343130892733027994 as (
with aggView2659145264002000707 as (select v9, MIN(v10) as v59 from aggView3407765237469235083 group by v9)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView2659145264002000707 where ci.person_role_id=aggView2659145264002000707.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin2028107828264363761 as (
with aggView4409931966784370105 as (select v35, MIN(v3) as v58 from aggView6431022756426713828 group by v35)
select v36, v35, v58 from aggView1960973902539518658 join aggView4409931966784370105 using(v35));
create or replace view aggJoin6604525440446778411 as (
with aggView1675632121784304165 as (select v35, MIN(v58) as v58, MIN(v36) as v60 from aggJoin2028107828264363761 group by v35,v58)
select v18, v20, v22, v59 as v59, v58, v60 from aggJoin8343130892733027994 join aggView1675632121784304165 using(v35));
create or replace view aggJoin2162896023215977936 as (
with aggView5334426790910600338 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v59, v58, v60 from aggJoin6604525440446778411 join aggView5334426790910600338 using(v22));
create or replace view aggJoin8291372540209788078 as (
with aggView3259886057840292000 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView3259886057840292000 where mc.company_id=aggView3259886057840292000.v32);
create or replace view aggJoin7261298486582226270 as (
with aggView4579249583452834832 as (select v18 from aggJoin8291372540209788078 group by v18)
select v18, v20, v59 as v59, v58 as v58, v60 as v60 from aggJoin2162896023215977936 join aggView4579249583452834832 using(v18));
create or replace view aggJoin5137958584381563377 as (
with aggView7755727805269362568 as (select v18, MIN(v59) as v59, MIN(v58) as v58, MIN(v60) as v60 from aggJoin7261298486582226270 group by v18,v58,v60,v59)
select v47, v59, v58, v60 from aggView4312097061521534939 join aggView7755727805269362568 using(v18));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v47) as v61 from aggJoin5137958584381563377;
