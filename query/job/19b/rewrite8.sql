create or replace view aggView2025399266531390014 as select id as v42, name as v43 from name as n where gender= 'f' and name LIKE '%Angel%';
create or replace view aggJoin4239147581451274456 as (
with aggView4939535820704453326 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView4939535820704453326 where mc.company_id=aggView4939535820704453326.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin1922457141855532919 as (
with aggView6856552268466760867 as (select v53 from aggJoin4239147581451274456 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView6856552268466760867 where t.id=aggView6856552268466760867.v53 and production_year>=2007 and production_year<=2008 and title LIKE '%Kung%Fu%Panda%');
create or replace view aggJoin8737640600992178550 as (
with aggView5751429692195416100 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView5751429692195416100 where mi.info_type_id=aggView5751429692195416100.v30 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin1292266893324446354 as (
with aggView4251756665705262059 as (select v53 from aggJoin8737640600992178550 group by v53)
select v53, v54, v57 from aggJoin1922457141855532919 join aggView4251756665705262059 using(v53));
create or replace view aggView5574973200107981740 as select v54, v53 from aggJoin1292266893324446354 group by v54,v53;
create or replace view aggJoin6685044499913314055 as (
with aggView6154573551177559217 as (select v53, MIN(v54) as v66 from aggView5574973200107981740 group by v53)
select person_id as v42, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView6154573551177559217 where ci.movie_id=aggView6154573551177559217.v53 and note= '(voice)');
create or replace view aggJoin3340712336744278246 as (
with aggView3709754947316592040 as (select person_id as v42 from aka_name as an group by person_id)
select v42, v9, v20, v51, v66 as v66 from aggJoin6685044499913314055 join aggView3709754947316592040 using(v42));
create or replace view aggJoin2920333952707839340 as (
with aggView804968164507296 as (select id as v9 from char_name as chn)
select v42, v20, v51, v66 from aggJoin3340712336744278246 join aggView804968164507296 using(v9));
create or replace view aggJoin4914211770731607919 as (
with aggView1925841896138807814 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v20, v66 from aggJoin2920333952707839340 join aggView1925841896138807814 using(v51));
create or replace view aggJoin3944092083629398763 as (
with aggView3034773170316103100 as (select v42, MIN(v66) as v66 from aggJoin4914211770731607919 group by v42,v66)
select v43, v66 from aggView2025399266531390014 join aggView3034773170316103100 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin3944092083629398763;
