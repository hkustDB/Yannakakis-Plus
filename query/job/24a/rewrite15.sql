create or replace view aggJoin1205024780978074981 as (
with aggView7798981712184199929 as (select id as v9, name as v71 from char_name as chn)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView7798981712184199929 where ci.person_role_id=aggView7798981712184199929.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin1522882261823710072 as (
with aggView69370406336422751 as (select id as v48, name as v72 from name as n where name LIKE '%An%' and gender= 'f')
select v48, v59, v20, v57, v71, v72 from aggJoin1205024780978074981 join aggView69370406336422751 using(v48));
create or replace view aggJoin9211916392969559278 as (
with aggView876213206581230877 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView876213206581230877 where mi.info_type_id=aggView876213206581230877.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin384920415632257885 as (
with aggView2544013298295101969 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v59 from movie_companies as mc, aggView2544013298295101969 where mc.company_id=aggView2544013298295101969.v23);
create or replace view aggJoin9173739844279297612 as (
with aggView5247778403962476267 as (select person_id as v48 from aka_name as an group by person_id)
select v59, v20, v57, v71 as v71, v72 as v72 from aggJoin1522882261823710072 join aggView5247778403962476267 using(v48));
create or replace view aggJoin4895499581455124511 as (
with aggView6605822266292784695 as (select id as v57 from role_type as rt where role= 'actress')
select v59, v20, v71, v72 from aggJoin9173739844279297612 join aggView6605822266292784695 using(v57));
create or replace view aggJoin1359588767799587631 as (
with aggView4378392144636799964 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select movie_id as v59 from movie_keyword as mk, aggView4378392144636799964 where mk.keyword_id=aggView4378392144636799964.v32);
create or replace view aggJoin8269927681221586601 as (
with aggView7961103374990273407 as (select v59 from aggJoin1359588767799587631 group by v59)
select id as v59, title as v60, production_year as v63 from title as t, aggView7961103374990273407 where t.id=aggView7961103374990273407.v59 and production_year>2010);
create or replace view aggJoin2100895484497806069 as (
with aggView671050813544633647 as (select v59, MIN(v60) as v73 from aggJoin8269927681221586601 group by v59)
select v59, v20, v71 as v71, v72 as v72, v73 from aggJoin4895499581455124511 join aggView671050813544633647 using(v59));
create or replace view aggJoin3887695875138698680 as (
with aggView2883601396717364372 as (select v59, MIN(v71) as v71, MIN(v72) as v72, MIN(v73) as v73 from aggJoin2100895484497806069 group by v59,v73,v72,v71)
select v59, v71, v72, v73 from aggJoin384920415632257885 join aggView2883601396717364372 using(v59));
create or replace view aggJoin6563272105040095075 as (
with aggView8559637325646974364 as (select v59, MIN(v71) as v71, MIN(v72) as v72, MIN(v73) as v73 from aggJoin3887695875138698680 group by v59,v73,v72,v71)
select v71, v72, v73 from aggJoin9211916392969559278 join aggView8559637325646974364 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin6563272105040095075;
