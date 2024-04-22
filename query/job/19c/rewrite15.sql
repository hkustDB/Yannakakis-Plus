create or replace view aggView7795861918346695006 as select name as v43, id as v42 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggJoin5781489236673177564 as (
with aggView6849377347900257458 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView6849377347900257458 where mi.info_type_id=aggView6849377347900257458.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin2739411628477976907 as (
with aggView4496374847168345743 as (select v53 from aggJoin5781489236673177564 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView4496374847168345743 where t.id=aggView4496374847168345743.v53 and production_year>2000);
create or replace view aggView3161209952177369870 as select v53, v54 from aggJoin2739411628477976907 group by v53,v54;
create or replace view aggJoin3958721728708387452 as (
with aggView7410628517854591407 as (select v42, MIN(v43) as v65 from aggView7795861918346695006 group by v42)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView7410628517854591407 where ci.person_id=aggView7410628517854591407.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin1401164998187224867 as (
with aggView4797096033534655693 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v53, v9, v20, v65 from aggJoin3958721728708387452 join aggView4797096033534655693 using(v51));
create or replace view aggJoin4151936515278671192 as (
with aggView3543603684576404491 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView3543603684576404491 where mc.company_id=aggView3543603684576404491.v23);
create or replace view aggJoin611334978441628540 as (
with aggView399502940858241858 as (select person_id as v42 from aka_name as an group by person_id)
select v53, v9, v20, v65 as v65 from aggJoin1401164998187224867 join aggView399502940858241858 using(v42));
create or replace view aggJoin459491190889699298 as (
with aggView7030269082625598870 as (select id as v9 from char_name as chn)
select v53, v20, v65 from aggJoin611334978441628540 join aggView7030269082625598870 using(v9));
create or replace view aggJoin8620106436502662357 as (
with aggView3481248514445365972 as (select v53 from aggJoin4151936515278671192 group by v53)
select v53, v20, v65 as v65 from aggJoin459491190889699298 join aggView3481248514445365972 using(v53));
create or replace view aggJoin8720136334322609963 as (
with aggView8437257386799970384 as (select v53, MIN(v65) as v65 from aggJoin8620106436502662357 group by v53,v65)
select v54, v65 from aggView3161209952177369870 join aggView8437257386799970384 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin8720136334322609963;
