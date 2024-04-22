create or replace view aggView9143171911771820489 as select name as v10, id as v9 from char_name as chn;
create or replace view aggJoin6399455785135511476 as (
with aggView2906370192524442915 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView2906370192524442915 where mc.company_id=aggView2906370192524442915.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin7512829356237711715 as (
with aggView2239848974111351836 as (select v18 from aggJoin6399455785135511476 group by v18)
select id as v18, title as v47, production_year as v50 from title as t, aggView2239848974111351836 where t.id=aggView2239848974111351836.v18 and production_year>=2005 and production_year<=2015);
create or replace view aggView4434119432397176148 as select v18, v47 from aggJoin7512829356237711715 group by v18,v47;
create or replace view aggJoin1808330319952166005 as (
with aggView1485492845220175479 as (select id as v35 from name as n where gender= 'f' and name LIKE '%Ang%')
select person_id as v35, name as v3 from aka_name as an, aggView1485492845220175479 where an.person_id=aggView1485492845220175479.v35);
create or replace view aggView4559432051594001583 as select v3, v35 from aggJoin1808330319952166005 group by v3,v35;
create or replace view aggJoin4645230081686479609 as (
with aggView2516471078380639213 as (select v35, MIN(v3) as v58 from aggView4559432051594001583 group by v35)
select movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v58 from cast_info as ci, aggView2516471078380639213 where ci.person_id=aggView2516471078380639213.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin1480322881818533324 as (
with aggView5906305836411296368 as (select v9, MIN(v10) as v59 from aggView9143171911771820489 group by v9)
select v18, v20, v22, v58 as v58, v59 from aggJoin4645230081686479609 join aggView5906305836411296368 using(v9));
create or replace view aggJoin1361497809368331063 as (
with aggView2109153134679514631 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v58, v59 from aggJoin1480322881818533324 join aggView2109153134679514631 using(v22));
create or replace view aggJoin6607205009188211099 as (
with aggView1874861838972510520 as (select v18, MIN(v58) as v58, MIN(v59) as v59 from aggJoin1361497809368331063 group by v18,v59,v58)
select v47, v58, v59 from aggView4434119432397176148 join aggView1874861838972510520 using(v18));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v47) as v60 from aggJoin6607205009188211099;
