create or replace view aggJoin6132891925009073616 as (
with aggView1264034952511025458 as (select id as v42, name as v43 from name as n where gender= 'f')
select v42, v43 from aggView1264034952511025458 where v43 LIKE '%Ang%');
create or replace view aggJoin3216133327681493462 as (
with aggView3645982823238292788 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView3645982823238292788 where mc.company_id=aggView3645982823238292788.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin5960906216732427072 as (
with aggView1863850491381451966 as (select v53 from aggJoin3216133327681493462 group by v53)
select movie_id as v53, info_type_id as v30, info as v40 from movie_info as mi, aggView1863850491381451966 where mi.movie_id=aggView1863850491381451966.v53 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin7484312551263885645 as (
with aggView2950877413468305722 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40 from aggJoin5960906216732427072 join aggView2950877413468305722 using(v30));
create or replace view aggJoin5774174745534617191 as (
with aggView7882030904822613441 as (select v53 from aggJoin7484312551263885645 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView7882030904822613441 where t.id=aggView7882030904822613441.v53 and production_year>=2005 and production_year<=2009);
create or replace view aggView7580161003537793111 as select v53, v54 from aggJoin5774174745534617191 group by v53,v54;
create or replace view aggJoin8610713029591431556 as (
with aggView3470374197756322387 as (select v53, MIN(v54) as v66 from aggView7580161003537793111 group by v53)
select person_id as v42, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView3470374197756322387 where ci.movie_id=aggView3470374197756322387.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin6475772665216524298 as (
with aggView8605679859425697359 as (select id as v9 from char_name as chn)
select v42, v20, v51, v66 from aggJoin8610713029591431556 join aggView8605679859425697359 using(v9));
create or replace view aggJoin6234919358616872620 as (
with aggView1547434210316441330 as (select person_id as v42 from aka_name as an group by person_id)
select v42, v20, v51, v66 as v66 from aggJoin6475772665216524298 join aggView1547434210316441330 using(v42));
create or replace view aggJoin7374130389948244797 as (
with aggView8060076441306696208 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v20, v66 from aggJoin6234919358616872620 join aggView8060076441306696208 using(v51));
create or replace view aggJoin3056313840345891074 as (
with aggView1489534448092543076 as (select v42, MIN(v66) as v66 from aggJoin7374130389948244797 group by v42,v66)
select v43, v66 from aggJoin6132891925009073616 join aggView1489534448092543076 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin3056313840345891074;
