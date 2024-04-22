create or replace view aggView6730455185295235478 as select id as v53, title as v54 from title as t where production_year>=2005 and production_year<=2009;
create or replace view aggJoin2918020132356138817 as (
with aggView7796555884890071639 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView7796555884890071639 where n.id=aggView7796555884890071639.v42 and gender= 'f');
create or replace view aggJoin2041708603995633477 as (
with aggView5614829915932635076 as (select v42, v43 from aggJoin2918020132356138817 group by v42,v43)
select v42, v43 from aggView5614829915932635076 where v43 LIKE '%Ang%');
create or replace view aggJoin8872245675097282261 as (
with aggView714323552139165286 as (select v42, MIN(v43) as v65 from aggJoin2041708603995633477 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView714323552139165286 where ci.person_id=aggView714323552139165286.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin3424711344408697162 as (
with aggView4215785995858981812 as (select id as v9 from char_name as chn)
select v53, v20, v51, v65 from aggJoin8872245675097282261 join aggView4215785995858981812 using(v9));
create or replace view aggJoin1106646339377841407 as (
with aggView2876207072249933396 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView2876207072249933396 where mc.company_id=aggView2876207072249933396.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin7589324472350135372 as (
with aggView7448570162165440059 as (select v53 from aggJoin1106646339377841407 group by v53)
select movie_id as v53, info_type_id as v30, info as v40 from movie_info as mi, aggView7448570162165440059 where mi.movie_id=aggView7448570162165440059.v53 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin4441220800821269109 as (
with aggView494891677905778122 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40 from aggJoin7589324472350135372 join aggView494891677905778122 using(v30));
create or replace view aggJoin4314714150786644565 as (
with aggView1119061434859741835 as (select v53 from aggJoin4441220800821269109 group by v53)
select v53, v20, v51, v65 as v65 from aggJoin3424711344408697162 join aggView1119061434859741835 using(v53));
create or replace view aggJoin3510663789242981610 as (
with aggView7959140195926088742 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v20, v65 from aggJoin4314714150786644565 join aggView7959140195926088742 using(v51));
create or replace view aggJoin5671115351049385135 as (
with aggView484658597895212808 as (select v53, MIN(v65) as v65 from aggJoin3510663789242981610 group by v53,v65)
select v54, v65 from aggView6730455185295235478 join aggView484658597895212808 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin5671115351049385135;
