create or replace view aggView8663898976131363201 as select name as v10, id as v9 from char_name as chn;
create or replace view aggView342282406508273576 as select id as v48, name as v49 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggJoin5628021906536263459 as (
with aggView7947588106771481039 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView7947588106771481039 where mi.info_type_id=aggView7947588106771481039.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin408101300728946838 as (
with aggView7039432983665552449 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v59 from movie_companies as mc, aggView7039432983665552449 where mc.company_id=aggView7039432983665552449.v23);
create or replace view aggJoin2797807401179944926 as (
with aggView5103269196016130940 as (select v59 from aggJoin5628021906536263459 group by v59)
select v59 from aggJoin408101300728946838 join aggView5103269196016130940 using(v59));
create or replace view aggJoin6929762561935050964 as (
with aggView6045260973077119330 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select movie_id as v59 from movie_keyword as mk, aggView6045260973077119330 where mk.keyword_id=aggView6045260973077119330.v32);
create or replace view aggJoin5504612522960915012 as (
with aggView4548015390548425367 as (select v59 from aggJoin6929762561935050964 group by v59)
select v59 from aggJoin2797807401179944926 join aggView4548015390548425367 using(v59));
create or replace view aggJoin8426046483651377376 as (
with aggView6218122770183664162 as (select v59 from aggJoin5504612522960915012 group by v59)
select id as v59, title as v60, production_year as v63 from title as t, aggView6218122770183664162 where t.id=aggView6218122770183664162.v59 and production_year>2010);
create or replace view aggView2441152332427919996 as select v59, v60 from aggJoin8426046483651377376 group by v59,v60;
create or replace view aggJoin7380170888416014418 as (
with aggView6694113537652893221 as (select v59, MIN(v60) as v73 from aggView2441152332427919996 group by v59)
select person_id as v48, person_role_id as v9, note as v20, role_id as v57, v73 from cast_info as ci, aggView6694113537652893221 where ci.movie_id=aggView6694113537652893221.v59 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin5008450191952741680 as (
with aggView3992158995719186381 as (select v48, MIN(v49) as v72 from aggView342282406508273576 group by v48)
select v48, v9, v20, v57, v73 as v73, v72 from aggJoin7380170888416014418 join aggView3992158995719186381 using(v48));
create or replace view aggJoin1357934042317220689 as (
with aggView3155311141835371300 as (select person_id as v48 from aka_name as an group by person_id)
select v9, v20, v57, v73 as v73, v72 as v72 from aggJoin5008450191952741680 join aggView3155311141835371300 using(v48));
create or replace view aggJoin1042295311588708019 as (
with aggView4291405218524827247 as (select id as v57 from role_type as rt where role= 'actress')
select v9, v20, v73, v72 from aggJoin1357934042317220689 join aggView4291405218524827247 using(v57));
create or replace view aggJoin6778711299899964506 as (
with aggView5167479850716345275 as (select v9, MIN(v73) as v73, MIN(v72) as v72 from aggJoin1042295311588708019 group by v9,v73,v72)
select v10, v73, v72 from aggView8663898976131363201 join aggView5167479850716345275 using(v9));
select MIN(v10) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin6778711299899964506;
