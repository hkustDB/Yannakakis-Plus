create or replace view aggJoin2724723153014392357 as (
with aggView4201579386374523062 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView4201579386374523062 where n.id=aggView4201579386374523062.v42 and gender= 'f');
create or replace view aggJoin5688333888234905175 as (
with aggView1997353625070905253 as (select v42, v43 from aggJoin2724723153014392357 group by v42,v43)
select v42, v43 from aggView1997353625070905253 where v43 LIKE '%Angel%');
create or replace view aggJoin7454145895309018855 as (
with aggView5739530366400734404 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView5739530366400734404 where mc.company_id=aggView5739530366400734404.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin7481274131777085390 as (
with aggView3519624740529728613 as (select v53 from aggJoin7454145895309018855 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView3519624740529728613 where t.id=aggView3519624740529728613.v53 and production_year>=2007 and production_year<=2008);
create or replace view aggJoin8552989358148184321 as (
with aggView7057974862181520270 as (select v54, v53 from aggJoin7481274131777085390 group by v54,v53)
select v53, v54 from aggView7057974862181520270 where v54 LIKE '%Kung%Fu%Panda%');
create or replace view aggJoin257373685809842517 as (
with aggView1807962878631805614 as (select v53, MIN(v54) as v66 from aggJoin8552989358148184321 group by v53)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView1807962878631805614 where ci.movie_id=aggView1807962878631805614.v53 and note= '(voice)');
create or replace view aggJoin1211568606926780168 as (
with aggView2512274328266816441 as (select id as v9 from char_name as chn)
select v42, v53, v20, v51, v66 from aggJoin257373685809842517 join aggView2512274328266816441 using(v9));
create or replace view aggJoin1341279407323035457 as (
with aggView1794198853001333613 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView1794198853001333613 where mi.info_type_id=aggView1794198853001333613.v30 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin5938997447265737328 as (
with aggView2201355725352849642 as (select v53 from aggJoin1341279407323035457 group by v53)
select v42, v20, v51, v66 as v66 from aggJoin1211568606926780168 join aggView2201355725352849642 using(v53));
create or replace view aggJoin8597419755786943134 as (
with aggView1416052259022198839 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v20, v66 from aggJoin5938997447265737328 join aggView1416052259022198839 using(v51));
create or replace view aggJoin5579377370825765194 as (
with aggView604949098297993289 as (select v42, MIN(v66) as v66 from aggJoin8597419755786943134 group by v42,v66)
select v43, v66 from aggJoin5688333888234905175 join aggView604949098297993289 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin5579377370825765194;
