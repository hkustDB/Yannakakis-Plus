create or replace view aggView7849235741480508241 as select id as v42, name as v43 from name as n where gender= 'f';
create or replace view aggJoin8068876990473773979 as (
with aggView7893237937724329417 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView7893237937724329417 where mi.info_type_id=aggView7893237937724329417.v30);
create or replace view aggJoin2236721827394555394 as (
with aggView7421053119609565421 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView7421053119609565421 where mc.company_id=aggView7421053119609565421.v23);
create or replace view aggJoin2466701889098194699 as (
with aggView2297739129027729597 as (select v53 from aggJoin8068876990473773979 group by v53)
select v53 from aggJoin2236721827394555394 join aggView2297739129027729597 using(v53));
create or replace view aggJoin3355850357162322210 as (
with aggView5042875828162612236 as (select v53 from aggJoin2466701889098194699 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView5042875828162612236 where t.id=aggView5042875828162612236.v53 and production_year>2000);
create or replace view aggView578618536479222 as select v53, v54 from aggJoin3355850357162322210 group by v53,v54;
create or replace view aggJoin5210986253843642027 as (
with aggView2156893247072165413 as (select v53, MIN(v54) as v66 from aggView578618536479222 group by v53)
select person_id as v42, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView2156893247072165413 where ci.movie_id=aggView2156893247072165413.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin2469438643103602003 as (
with aggView1174225629998855516 as (select person_id as v42 from aka_name as an group by person_id)
select v42, v9, v20, v51, v66 as v66 from aggJoin5210986253843642027 join aggView1174225629998855516 using(v42));
create or replace view aggJoin5611330324592963005 as (
with aggView4267615874876611757 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v9, v20, v66 from aggJoin2469438643103602003 join aggView4267615874876611757 using(v51));
create or replace view aggJoin797817485135895761 as (
with aggView4951694590404730029 as (select id as v9 from char_name as chn)
select v42, v20, v66 from aggJoin5611330324592963005 join aggView4951694590404730029 using(v9));
create or replace view aggJoin1384400537185572816 as (
with aggView1970114556699647327 as (select v42, MIN(v66) as v66 from aggJoin797817485135895761 group by v42,v66)
select v43, v66 from aggView7849235741480508241 join aggView1970114556699647327 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin1384400537185572816;
