create or replace view aggView7575493553914579456 as select id as v1, name as v2 from char_name as chn;
create or replace view aggView4628809953112564743 as select title as v32, id as v31 from title as t where production_year>2010;
create or replace view aggJoin7123946497763496656 as (
with aggView8142368016872468321 as (select v31, MIN(v32) as v44 from aggView4628809953112564743 group by v31)
select movie_id as v31, person_role_id as v1, note as v12, role_id as v29, v44 from cast_info as ci, aggView8142368016872468321 where ci.movie_id=aggView8142368016872468321.v31 and note LIKE '%(producer)%');
create or replace view aggJoin1887643625821225175 as (
with aggView5531809304110498510 as (select id as v29 from role_type as rt where role= 'actor')
select v31, v1, v12, v44 from aggJoin7123946497763496656 join aggView5531809304110498510 using(v29));
create or replace view aggJoin5967494047258883583 as (
with aggView4536812217339145191 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView4536812217339145191 where mc.company_type_id=aggView4536812217339145191.v22);
create or replace view aggJoin2070372902328648509 as (
with aggView3400498229918642337 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v31 from aggJoin5967494047258883583 join aggView3400498229918642337 using(v15));
create or replace view aggJoin7583731820094264893 as (
with aggView1870536041011751668 as (select v31 from aggJoin2070372902328648509 group by v31)
select v1, v12, v44 as v44 from aggJoin1887643625821225175 join aggView1870536041011751668 using(v31));
create or replace view aggJoin3949239767792188942 as (
with aggView1396691786278630898 as (select v1, MIN(v44) as v44 from aggJoin7583731820094264893 group by v1,v44)
select v2, v44 from aggView7575493553914579456 join aggView1396691786278630898 using(v1));
select MIN(v2) as v43,MIN(v44) as v44 from aggJoin3949239767792188942;
