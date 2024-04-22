create or replace view aggJoin3838868562346004297 as (
with aggView8750943356120015994 as (select id as v53, title as v66 from title as t where production_year>=2005 and production_year<=2009)
select movie_id as v53, info_type_id as v30, info as v40, v66 from movie_info as mi, aggView8750943356120015994 where mi.movie_id=aggView8750943356120015994.v53 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin1677341779819539651 as (
with aggView1404413348679279047 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView1404413348679279047 where n.id=aggView1404413348679279047.v42 and name LIKE '%Ang%' and gender= 'f');
create or replace view aggJoin6527746062364416895 as (
with aggView74496402455374242 as (select v42, MIN(v43) as v65 from aggJoin1677341779819539651 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView74496402455374242 where ci.person_id=aggView74496402455374242.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4684340609907005696 as (
with aggView4999524800264567431 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView4999524800264567431 where mc.company_id=aggView4999524800264567431.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin6890702655344135122 as (
with aggView6478965953759230672 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40, v66 from aggJoin3838868562346004297 join aggView6478965953759230672 using(v30));
create or replace view aggJoin7277526093955286071 as (
with aggView7444169039245723533 as (select v53, MIN(v66) as v66 from aggJoin6890702655344135122 group by v53,v66)
select v53, v36, v66 from aggJoin4684340609907005696 join aggView7444169039245723533 using(v53));
create or replace view aggJoin8546596994489876509 as (
with aggView2193284538463505822 as (select v53, MIN(v66) as v66 from aggJoin7277526093955286071 group by v53,v66)
select v9, v20, v51, v65 as v65, v66 from aggJoin6527746062364416895 join aggView2193284538463505822 using(v53));
create or replace view aggJoin9179847253209637962 as (
with aggView2320037072144532744 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v65, v66 from aggJoin8546596994489876509 join aggView2320037072144532744 using(v51));
create or replace view aggJoin4575053600879014135 as (
with aggView70050321348796648 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin9179847253209637962 group by v9,v66,v65)
select v65, v66 from char_name as chn, aggView70050321348796648 where chn.id=aggView70050321348796648.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin4575053600879014135;
