create or replace view aggJoin5444899818005408209 as (
with aggView5060744755866625849 as (select id as v42, name as v65 from name as n where gender= 'f')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView5060744755866625849 where ci.person_id=aggView5060744755866625849.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin7412529262619129706 as (
with aggView3464982549216638493 as (select person_id as v42 from aka_name as an group by person_id)
select v53, v9, v20, v51, v65 as v65 from aggJoin5444899818005408209 join aggView3464982549216638493 using(v42));
create or replace view aggJoin6391137547889650938 as (
with aggView3634499796071846038 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v9, v20, v65 from aggJoin7412529262619129706 join aggView3634499796071846038 using(v51));
create or replace view aggJoin6249266357332757366 as (
with aggView1789791945394895085 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView1789791945394895085 where mc.company_id=aggView1789791945394895085.v23);
create or replace view aggJoin1195236701584293422 as (
with aggView2940313585001398347 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView2940313585001398347 where mi.info_type_id=aggView2940313585001398347.v30);
create or replace view aggJoin7210752277201746319 as (
with aggView176301472579060732 as (select id as v9 from char_name as chn)
select v53, v20, v65 from aggJoin6391137547889650938 join aggView176301472579060732 using(v9));
create or replace view aggJoin8289320735708201697 as (
with aggView3486382779166144578 as (select v53, MIN(v65) as v65 from aggJoin7210752277201746319 group by v53,v65)
select id as v53, title as v54, production_year as v57, v65 from title as t, aggView3486382779166144578 where t.id=aggView3486382779166144578.v53 and production_year>2000);
create or replace view aggJoin5815819161395935580 as (
with aggView697190798811796214 as (select v53, MIN(v65) as v65, MIN(v54) as v66 from aggJoin8289320735708201697 group by v53,v65)
select v53, v65, v66 from aggJoin6249266357332757366 join aggView697190798811796214 using(v53));
create or replace view aggJoin3177130210612332314 as (
with aggView2753549378660758210 as (select v53, MIN(v65) as v65, MIN(v66) as v66 from aggJoin5815819161395935580 group by v53,v65,v66)
select v65, v66 from aggJoin1195236701584293422 join aggView2753549378660758210 using(v53));
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin3177130210612332314;
