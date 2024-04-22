create or replace view aggView7625142828471429247 as select name as v10, id as v9 from char_name as chn;
create or replace view aggJoin5927014761546200122 as (
with aggView3125612638867494337 as (select id as v48, name as v49 from name as n where gender= 'f')
select v48, v49 from aggView3125612638867494337 where v49 LIKE '%An%');
create or replace view aggJoin4540069540082028565 as (
with aggView599856324863704394 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView599856324863704394 where mi.info_type_id=aggView599856324863704394.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin2836752414469537868 as (
with aggView3828311179813477935 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v59 from movie_companies as mc, aggView3828311179813477935 where mc.company_id=aggView3828311179813477935.v23);
create or replace view aggJoin6012200845495382055 as (
with aggView6471860408826757708 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select movie_id as v59 from movie_keyword as mk, aggView6471860408826757708 where mk.keyword_id=aggView6471860408826757708.v32);
create or replace view aggJoin4441267160985268878 as (
with aggView8396824316994761363 as (select v59 from aggJoin6012200845495382055 group by v59)
select v59, v43 from aggJoin4540069540082028565 join aggView8396824316994761363 using(v59));
create or replace view aggJoin1259188504898657620 as (
with aggView1975343318843178656 as (select v59 from aggJoin4441267160985268878 group by v59)
select v59 from aggJoin2836752414469537868 join aggView1975343318843178656 using(v59));
create or replace view aggJoin6623743042716373052 as (
with aggView3324113189646403289 as (select v59 from aggJoin1259188504898657620 group by v59)
select id as v59, title as v60, production_year as v63 from title as t, aggView3324113189646403289 where t.id=aggView3324113189646403289.v59 and production_year>2010);
create or replace view aggView6196827206423457156 as select v59, v60 from aggJoin6623743042716373052 group by v59,v60;
create or replace view aggJoin5382426018834321868 as (
with aggView705058654809705430 as (select v59, MIN(v60) as v73 from aggView6196827206423457156 group by v59)
select person_id as v48, person_role_id as v9, note as v20, role_id as v57, v73 from cast_info as ci, aggView705058654809705430 where ci.movie_id=aggView705058654809705430.v59 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4003964245418800510 as (
with aggView2955698331157324939 as (select v48, MIN(v49) as v72 from aggJoin5927014761546200122 group by v48)
select v48, v9, v20, v57, v73 as v73, v72 from aggJoin5382426018834321868 join aggView2955698331157324939 using(v48));
create or replace view aggJoin1735126814488451812 as (
with aggView5630870947011899404 as (select person_id as v48 from aka_name as an group by person_id)
select v9, v20, v57, v73 as v73, v72 as v72 from aggJoin4003964245418800510 join aggView5630870947011899404 using(v48));
create or replace view aggJoin6074221504789827768 as (
with aggView3654854893764954106 as (select id as v57 from role_type as rt where role= 'actress')
select v9, v20, v73, v72 from aggJoin1735126814488451812 join aggView3654854893764954106 using(v57));
create or replace view aggJoin4553356921900913697 as (
with aggView7928972048895319870 as (select v9, MIN(v73) as v73, MIN(v72) as v72 from aggJoin6074221504789827768 group by v9,v73,v72)
select v10, v73, v72 from aggView7625142828471429247 join aggView7928972048895319870 using(v9));
select MIN(v10) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin4553356921900913697;
