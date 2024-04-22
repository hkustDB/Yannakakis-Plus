create or replace view aggView674934443656206217 as select id as v42, name as v43 from name as n where gender= 'f' and name LIKE '%Angel%';
create or replace view aggJoin4429354448917001466 as (
with aggView6842667794562811535 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView6842667794562811535 where mc.company_id=aggView6842667794562811535.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin5530044612788895305 as (
with aggView5912927689296752542 as (select v53 from aggJoin4429354448917001466 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView5912927689296752542 where t.id=aggView5912927689296752542.v53 and production_year>=2007 and production_year<=2008 and title LIKE '%Kung%Fu%Panda%');
create or replace view aggJoin5987293717661864236 as (
with aggView292718141380320477 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView292718141380320477 where mi.info_type_id=aggView292718141380320477.v30 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin553763101789412273 as (
with aggView5883832465976920643 as (select v53 from aggJoin5987293717661864236 group by v53)
select v53, v54, v57 from aggJoin5530044612788895305 join aggView5883832465976920643 using(v53));
create or replace view aggView5518331286899433542 as select v54, v53 from aggJoin553763101789412273 group by v54,v53;
create or replace view aggJoin3105460056227200145 as (
with aggView8589881114159386096 as (select v42, MIN(v43) as v65 from aggView674934443656206217 group by v42)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView8589881114159386096 where ci.person_id=aggView8589881114159386096.v42 and note= '(voice)');
create or replace view aggJoin4425338321404838633 as (
with aggView6416344455125741133 as (select person_id as v42 from aka_name as an group by person_id)
select v53, v9, v20, v51, v65 as v65 from aggJoin3105460056227200145 join aggView6416344455125741133 using(v42));
create or replace view aggJoin1174374722807531248 as (
with aggView4082905323472538146 as (select id as v9 from char_name as chn)
select v53, v20, v51, v65 from aggJoin4425338321404838633 join aggView4082905323472538146 using(v9));
create or replace view aggJoin7303333728168203194 as (
with aggView8225046740655724364 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v20, v65 from aggJoin1174374722807531248 join aggView8225046740655724364 using(v51));
create or replace view aggJoin5819143651097914562 as (
with aggView4014150296717622069 as (select v53, MIN(v65) as v65 from aggJoin7303333728168203194 group by v53,v65)
select v54, v65 from aggView5518331286899433542 join aggView4014150296717622069 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin5819143651097914562;
