create or replace view aggJoin4228750850262033147 as (
with aggView1101291939942582917 as (select id as v42, name as v65 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v42, v65 from aka_name as an, aggView1101291939942582917 where an.person_id=aggView1101291939942582917.v42);
create or replace view aggJoin1096874099444504459 as (
with aggView8942189941966650275 as (select id as v51 from role_type as rt where role= 'actress')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20 from cast_info as ci, aggView8942189941966650275 where ci.role_id=aggView8942189941966650275.v51 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin6473934334426084237 as (
with aggView7231549066374826163 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView7231549066374826163 where mi.info_type_id=aggView7231549066374826163.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin4057256683855359037 as (
with aggView1135482324051260925 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView1135482324051260925 where mc.company_id=aggView1135482324051260925.v23);
create or replace view aggJoin3925475218218056180 as (
with aggView6768698179122332140 as (select v42, MIN(v65) as v65 from aggJoin4228750850262033147 group by v42,v65)
select v53, v9, v20, v65 from aggJoin1096874099444504459 join aggView6768698179122332140 using(v42));
create or replace view aggJoin8792638793428749728 as (
with aggView3041452172918164384 as (select v53 from aggJoin4057256683855359037 group by v53)
select v53, v40 from aggJoin6473934334426084237 join aggView3041452172918164384 using(v53));
create or replace view aggJoin8767644058509682916 as (
with aggView5159173634784437452 as (select v53 from aggJoin8792638793428749728 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView5159173634784437452 where t.id=aggView5159173634784437452.v53 and production_year>2000);
create or replace view aggJoin3801405035866113963 as (
with aggView8919568363585088916 as (select v53, MIN(v54) as v66 from aggJoin8767644058509682916 group by v53)
select v9, v20, v65 as v65, v66 from aggJoin3925475218218056180 join aggView8919568363585088916 using(v53));
create or replace view aggJoin8463049912357407716 as (
with aggView4249956938550336527 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin3801405035866113963 group by v9,v66,v65)
select v65, v66 from char_name as chn, aggView4249956938550336527 where chn.id=aggView4249956938550336527.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin8463049912357407716;
