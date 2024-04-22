create or replace view aggView8557471715112476162 as select name as v2, id as v1 from char_name as chn;
create or replace view aggView691075826960134590 as select id as v31, title as v32 from title as t where production_year>1990;
create or replace view aggJoin1033446918453686506 as (
with aggView3616554105416071684 as (select v1, MIN(v2) as v43 from aggView8557471715112476162 group by v1)
select movie_id as v31, note as v12, role_id as v29, v43 from cast_info as ci, aggView3616554105416071684 where ci.person_role_id=aggView3616554105416071684.v1 and note LIKE '%(producer)%');
create or replace view aggJoin7934328875817306316 as (
with aggView7318732267132612802 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView7318732267132612802 where mc.company_type_id=aggView7318732267132612802.v22);
create or replace view aggJoin1942088206600614190 as (
with aggView5767320927660063312 as (select id as v29 from role_type as rt)
select v31, v12, v43 from aggJoin1033446918453686506 join aggView5767320927660063312 using(v29));
create or replace view aggJoin459043839477339182 as (
with aggView4194257007004274085 as (select id as v15 from company_name as cn where country_code= '[us]')
select v31 from aggJoin7934328875817306316 join aggView4194257007004274085 using(v15));
create or replace view aggJoin8432969526668059046 as (
with aggView6470389005814981442 as (select v31 from aggJoin459043839477339182 group by v31)
select v31, v12, v43 as v43 from aggJoin1942088206600614190 join aggView6470389005814981442 using(v31));
create or replace view aggJoin7444895867820957369 as (
with aggView462068040153593544 as (select v31, MIN(v43) as v43 from aggJoin8432969526668059046 group by v31,v43)
select v32, v43 from aggView691075826960134590 join aggView462068040153593544 using(v31));
select MIN(v43) as v43,MIN(v32) as v44 from aggJoin7444895867820957369;
