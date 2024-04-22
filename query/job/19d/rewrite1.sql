create or replace view aggJoin5040551645728490472 as (
with aggView4742156299873797278 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView4742156299873797278 where mc.company_id=aggView4742156299873797278.v23);
create or replace view aggJoin5940061275996021309 as (
with aggView6305139127501830580 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView6305139127501830580 where mi.info_type_id=aggView6305139127501830580.v30);
create or replace view aggJoin6954184006837266402 as (
with aggView2044925419493790256 as (select v53 from aggJoin5040551645728490472 group by v53)
select v53 from aggJoin5940061275996021309 join aggView2044925419493790256 using(v53));
create or replace view aggJoin6351451341867267731 as (
with aggView8166977637261166762 as (select v53 from aggJoin6954184006837266402 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView8166977637261166762 where t.id=aggView8166977637261166762.v53 and production_year>2000);
create or replace view aggView3207250338282901422 as select v53, v54 from aggJoin6351451341867267731 group by v53,v54;
create or replace view aggJoin7815722942814215280 as (
with aggView5840314879432992869 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView5840314879432992869 where n.id=aggView5840314879432992869.v42 and gender= 'f');
create or replace view aggView4154190963202534896 as select v42, v43 from aggJoin7815722942814215280 group by v42,v43;
create or replace view aggJoin5624816099417226161 as (
with aggView486597667557526725 as (select v53, MIN(v54) as v66 from aggView3207250338282901422 group by v53)
select person_id as v42, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView486597667557526725 where ci.movie_id=aggView486597667557526725.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin2915031486852178251 as (
with aggView4242161303007910395 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v9, v20, v66 from aggJoin5624816099417226161 join aggView4242161303007910395 using(v51));
create or replace view aggJoin6535019458914749770 as (
with aggView2545469668620436262 as (select id as v9 from char_name as chn)
select v42, v20, v66 from aggJoin2915031486852178251 join aggView2545469668620436262 using(v9));
create or replace view aggJoin1295508188059884009 as (
with aggView4745098411047292260 as (select v42, MIN(v66) as v66 from aggJoin6535019458914749770 group by v42,v66)
select v43, v66 from aggView4154190963202534896 join aggView4745098411047292260 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin1295508188059884009;
