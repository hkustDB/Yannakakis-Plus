create or replace view aggJoin7909133823795814846 as (
with aggView1395506902126715511 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView1395506902126715511 where mk.keyword_id=aggView1395506902126715511.v24);
create or replace view aggJoin7164582988119908842 as (
with aggView4407042864409332154 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView4407042864409332154 where mc.company_id=aggView4407042864409332154.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin7526052288201205105 as (
with aggView4807805077935555492 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select id as v40, title as v41, production_year as v44 from title as t, aggView4807805077935555492 where t.id=aggView4807805077935555492.v40 and production_year>2000);
create or replace view aggJoin6208896745888597488 as (
with aggView4165035256749919315 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin7164582988119908842 join aggView4165035256749919315 using(v20));
create or replace view aggJoin4753266360078943544 as (
with aggView6772091471657900125 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView6772091471657900125 where mi.info_type_id=aggView6772091471657900125.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin4042582059900839929 as (
with aggView6667361476748767635 as (select v40 from aggJoin6208896745888597488 group by v40)
select v40, v41, v44 from aggJoin7526052288201205105 join aggView6667361476748767635 using(v40));
create or replace view aggJoin7282673884442258492 as (
with aggView3661571244596694941 as (select v40, MIN(v41) as v53 from aggJoin4042582059900839929 group by v40)
select v40, v35, v36, v53 from aggJoin4753266360078943544 join aggView3661571244596694941 using(v40));
create or replace view aggJoin348365757891429193 as (
with aggView12944156962898718 as (select v40, MIN(v53) as v53, MIN(v35) as v52 from aggJoin7282673884442258492 group by v40,v53)
select v53, v52 from aggJoin7909133823795814846 join aggView12944156962898718 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin348365757891429193;
