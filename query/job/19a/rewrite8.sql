create or replace view aggJoin3382857733773944942 as (
with aggView8611017477117081281 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView8611017477117081281 where n.id=aggView8611017477117081281.v42 and gender= 'f');
create or replace view aggJoin1025410412558591651 as (
with aggView3256526272548854647 as (select v42, v43 from aggJoin3382857733773944942 group by v42,v43)
select v42, v43 from aggView3256526272548854647 where v43 LIKE '%Ang%');
create or replace view aggJoin2313682907823266219 as (
with aggView4431221021321708179 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView4431221021321708179 where mi.info_type_id=aggView4431221021321708179.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin2656711877535202779 as (
with aggView4369673288892475961 as (select v53 from aggJoin2313682907823266219 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView4369673288892475961 where t.id=aggView4369673288892475961.v53 and production_year>=2005 and production_year<=2009);
create or replace view aggView2294642691331651850 as select v53, v54 from aggJoin2656711877535202779 group by v53,v54;
create or replace view aggJoin5306311475577525786 as (
with aggView2979750143776841759 as (select v42, MIN(v43) as v65 from aggJoin1025410412558591651 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView2979750143776841759 where ci.person_id=aggView2979750143776841759.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin6959724137316745954 as (
with aggView5721385058999775912 as (select id as v9 from char_name as chn)
select v53, v20, v51, v65 from aggJoin5306311475577525786 join aggView5721385058999775912 using(v9));
create or replace view aggJoin4361626922662448889 as (
with aggView4042455561789983703 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView4042455561789983703 where mc.company_id=aggView4042455561789983703.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin2446817514243080151 as (
with aggView8071118725396704973 as (select v53 from aggJoin4361626922662448889 group by v53)
select v53, v20, v51, v65 as v65 from aggJoin6959724137316745954 join aggView8071118725396704973 using(v53));
create or replace view aggJoin2487999791647419145 as (
with aggView2192946230065298677 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v20, v65 from aggJoin2446817514243080151 join aggView2192946230065298677 using(v51));
create or replace view aggJoin9074663622227028209 as (
with aggView505619453546993195 as (select v53, MIN(v65) as v65 from aggJoin2487999791647419145 group by v53,v65)
select v54, v65 from aggView2294642691331651850 join aggView505619453546993195 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin9074663622227028209;
