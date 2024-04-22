create or replace view aggView6737274275315606566 as select id as v42, name as v43 from name as n where name LIKE '%Ang%' and gender= 'f';
create or replace view aggJoin5489235462401352946 as (
with aggView4364743758906412953 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView4364743758906412953 where mi.info_type_id=aggView4364743758906412953.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin3622689920119947379 as (
with aggView3186536732658708739 as (select v53 from aggJoin5489235462401352946 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView3186536732658708739 where t.id=aggView3186536732658708739.v53 and production_year>=2005 and production_year<=2009);
create or replace view aggView1831521515679761250 as select v53, v54 from aggJoin3622689920119947379 group by v53,v54;
create or replace view aggJoin8730130271055387569 as (
with aggView4119687137735421782 as (select v53, MIN(v54) as v66 from aggView1831521515679761250 group by v53)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView4119687137735421782 where ci.movie_id=aggView4119687137735421782.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4255281850013860421 as (
with aggView8406419371460121933 as (select id as v9 from char_name as chn)
select v42, v53, v20, v51, v66 from aggJoin8730130271055387569 join aggView8406419371460121933 using(v9));
create or replace view aggJoin81201668276843659 as (
with aggView4370235557398948307 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView4370235557398948307 where mc.company_id=aggView4370235557398948307.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin2279710807368845047 as (
with aggView2650741989474217242 as (select v53 from aggJoin81201668276843659 group by v53)
select v42, v20, v51, v66 as v66 from aggJoin4255281850013860421 join aggView2650741989474217242 using(v53));
create or replace view aggJoin791396975473380009 as (
with aggView4544215547835184114 as (select person_id as v42 from aka_name as an group by person_id)
select v42, v20, v51, v66 as v66 from aggJoin2279710807368845047 join aggView4544215547835184114 using(v42));
create or replace view aggJoin4171622791702641834 as (
with aggView7050925464266739298 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v20, v66 from aggJoin791396975473380009 join aggView7050925464266739298 using(v51));
create or replace view aggJoin1565173231939525881 as (
with aggView2657710293402346465 as (select v42, MIN(v66) as v66 from aggJoin4171622791702641834 group by v42,v66)
select v43, v66 from aggView6737274275315606566 join aggView2657710293402346465 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin1565173231939525881;
