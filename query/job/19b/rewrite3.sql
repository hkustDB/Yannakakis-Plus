create or replace view aggJoin8152356727190310015 as (
with aggView6026026784187849894 as (select id as v53, title as v66 from title as t where production_year>=2007 and production_year<=2008 and title LIKE '%Kung%Fu%Panda%')
select movie_id as v53, company_id as v23, note as v36, v66 from movie_companies as mc, aggView6026026784187849894 where mc.movie_id=aggView6026026784187849894.v53 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin3353992887727864662 as (
with aggView2260246563023146129 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView2260246563023146129 where n.id=aggView2260246563023146129.v42 and gender= 'f' and name LIKE '%Angel%');
create or replace view aggJoin2338591530940893678 as (
with aggView1568745675261037930 as (select v42, MIN(v43) as v65 from aggJoin3353992887727864662 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView1568745675261037930 where ci.person_id=aggView1568745675261037930.v42 and note= '(voice)');
create or replace view aggJoin4026951133310385933 as (
with aggView3997360344236499496 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView3997360344236499496 where mi.info_type_id=aggView3997360344236499496.v30 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin5403703305605208408 as (
with aggView6008429695490315571 as (select v53 from aggJoin4026951133310385933 group by v53)
select v53, v23, v36, v66 as v66 from aggJoin8152356727190310015 join aggView6008429695490315571 using(v53));
create or replace view aggJoin1748686731373036773 as (
with aggView2164723284674890616 as (select id as v23 from company_name as cn where country_code= '[us]')
select v53, v36, v66 from aggJoin5403703305605208408 join aggView2164723284674890616 using(v23));
create or replace view aggJoin7356325272524715081 as (
with aggView2918429245346672518 as (select v53, MIN(v66) as v66 from aggJoin1748686731373036773 group by v53,v66)
select v9, v20, v51, v65 as v65, v66 from aggJoin2338591530940893678 join aggView2918429245346672518 using(v53));
create or replace view aggJoin2783145899994106745 as (
with aggView8211599731890419222 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v65, v66 from aggJoin7356325272524715081 join aggView8211599731890419222 using(v51));
create or replace view aggJoin7015090534455417502 as (
with aggView3121048026080547484 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin2783145899994106745 group by v9,v65,v66)
select v65, v66 from char_name as chn, aggView3121048026080547484 where chn.id=aggView3121048026080547484.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin7015090534455417502;
