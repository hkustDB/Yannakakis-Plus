create or replace view aggJoin7804286155792163679 as (
with aggView3303437622203525092 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, v49 from movie_companies as mc, aggView3303437622203525092 where mc.company_id=aggView3303437622203525092.v1);
create or replace view aggJoin604602849729766814 as (
with aggView4927178153576913122 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView4927178153576913122 where mi.info_type_id=aggView4927178153576913122.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin797671667515295348 as (
with aggView4195963081362967265 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView4195963081362967265 where mk.keyword_id=aggView4195963081362967265.v14);
create or replace view aggJoin4807861527681452235 as (
with aggView8090774329152742370 as (select id as v8 from company_type as ct)
select v37, v49 from aggJoin7804286155792163679 join aggView8090774329152742370 using(v8));
create or replace view aggJoin127118158359088578 as (
with aggView6677544706467188062 as (select v37, MIN(v49) as v49 from aggJoin4807861527681452235 group by v37,v49)
select id as v37, title as v38, kind_id as v17, production_year as v41, v49 from title as t, aggView6677544706467188062 where t.id=aggView6677544706467188062.v37 and production_year>2005);
create or replace view aggJoin2959103977013973793 as (
with aggView3357294528701671755 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView3357294528701671755 where mi_idx.info_type_id=aggView3357294528701671755.v12 and info<'8.5');
create or replace view aggJoin1840330631836727259 as (
with aggView6486582962742214515 as (select v37 from aggJoin604602849729766814 group by v37)
select v37, v32 from aggJoin2959103977013973793 join aggView6486582962742214515 using(v37));
create or replace view aggJoin9026010180852750653 as (
with aggView7585260260243837909 as (select v37, MIN(v32) as v50 from aggJoin1840330631836727259 group by v37)
select v37, v50 from aggJoin797671667515295348 join aggView7585260260243837909 using(v37));
create or replace view aggJoin5500557825889153504 as (
with aggView2911825663538010287 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select v37, v38, v41, v49 from aggJoin127118158359088578 join aggView2911825663538010287 using(v17));
create or replace view aggJoin5018368413606170795 as (
with aggView6473382587024836621 as (select v37, MIN(v49) as v49, MIN(v38) as v51 from aggJoin5500557825889153504 group by v37,v49)
select v50 as v50, v49, v51 from aggJoin9026010180852750653 join aggView6473382587024836621 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin5018368413606170795;
