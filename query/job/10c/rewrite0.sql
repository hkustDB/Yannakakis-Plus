create or replace view aggView7926097717354262819 as select name as v2, id as v1 from char_name as chn;
create or replace view aggJoin2826319713324019778 as (
with aggView7080440692942977659 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView7080440692942977659 where mc.company_type_id=aggView7080440692942977659.v22);
create or replace view aggJoin1230386024988282071 as (
with aggView5635139777367201294 as (select id as v15 from company_name as cn where country_code= '[us]')
select v31 from aggJoin2826319713324019778 join aggView5635139777367201294 using(v15));
create or replace view aggJoin606485027417809404 as (
with aggView3450776391791838574 as (select v31 from aggJoin1230386024988282071 group by v31)
select id as v31, title as v32, production_year as v35 from title as t, aggView3450776391791838574 where t.id=aggView3450776391791838574.v31 and production_year>1990);
create or replace view aggView7197255700306560937 as select v31, v32 from aggJoin606485027417809404 group by v31,v32;
create or replace view aggJoin3630774685337763902 as (
with aggView3097615169812260904 as (select v31, MIN(v32) as v44 from aggView7197255700306560937 group by v31)
select person_role_id as v1, note as v12, role_id as v29, v44 from cast_info as ci, aggView3097615169812260904 where ci.movie_id=aggView3097615169812260904.v31 and note LIKE '%(producer)%');
create or replace view aggJoin360079327932519917 as (
with aggView4099742691789746510 as (select id as v29 from role_type as rt)
select v1, v12, v44 from aggJoin3630774685337763902 join aggView4099742691789746510 using(v29));
create or replace view aggJoin5279607141464444634 as (
with aggView5616813467542148959 as (select v1, MIN(v44) as v44 from aggJoin360079327932519917 group by v1,v44)
select v2, v44 from aggView7926097717354262819 join aggView5616813467542148959 using(v1));
select MIN(v2) as v43,MIN(v44) as v44 from aggJoin5279607141464444634;
