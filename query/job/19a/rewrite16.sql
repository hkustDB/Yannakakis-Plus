create or replace view aggView3360657634180886726 as select id as v53, title as v54 from title as t where production_year>=2005 and production_year<=2009;
create or replace view aggJoin7465479651600940606 as (
with aggView2456478756781785519 as (select id as v42, name as v43 from name as n where gender= 'f')
select v42, v43 from aggView2456478756781785519 where v43 LIKE '%Ang%');
create or replace view aggJoin3400845136809995956 as (
with aggView2874235283757308072 as (select v53, MIN(v54) as v66 from aggView3360657634180886726 group by v53)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView2874235283757308072 where ci.movie_id=aggView2874235283757308072.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4487897581102514914 as (
with aggView5938520288235721500 as (select id as v9 from char_name as chn)
select v42, v53, v20, v51, v66 from aggJoin3400845136809995956 join aggView5938520288235721500 using(v9));
create or replace view aggJoin4335488509367010885 as (
with aggView1577519600701954825 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView1577519600701954825 where mc.company_id=aggView1577519600701954825.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin2027609204215421930 as (
with aggView4241773127906026162 as (select v53 from aggJoin4335488509367010885 group by v53)
select movie_id as v53, info_type_id as v30, info as v40 from movie_info as mi, aggView4241773127906026162 where mi.movie_id=aggView4241773127906026162.v53 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin4135801956704021128 as (
with aggView3599528341651043025 as (select person_id as v42 from aka_name as an group by person_id)
select v42, v53, v20, v51, v66 as v66 from aggJoin4487897581102514914 join aggView3599528341651043025 using(v42));
create or replace view aggJoin162487895354242044 as (
with aggView448772867948299557 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40 from aggJoin2027609204215421930 join aggView448772867948299557 using(v30));
create or replace view aggJoin489956494604253089 as (
with aggView225949046426719906 as (select v53 from aggJoin162487895354242044 group by v53)
select v42, v20, v51, v66 as v66 from aggJoin4135801956704021128 join aggView225949046426719906 using(v53));
create or replace view aggJoin4792409679379050811 as (
with aggView2636954455307711784 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v20, v66 from aggJoin489956494604253089 join aggView2636954455307711784 using(v51));
create or replace view aggJoin5618200775744908202 as (
with aggView8172994299390776442 as (select v42, MIN(v66) as v66 from aggJoin4792409679379050811 group by v42,v66)
select v43, v66 from aggJoin7465479651600940606 join aggView8172994299390776442 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin5618200775744908202;
