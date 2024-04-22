create or replace view aggJoin2535248781113983680 as (
with aggView2170544889168008566 as (select id as v31, title as v44 from title as t where production_year>2010)
select movie_id as v31, company_id as v15, company_type_id as v22, v44 from movie_companies as mc, aggView2170544889168008566 where mc.movie_id=aggView2170544889168008566.v31);
create or replace view aggJoin6590921452612200677 as (
with aggView5034418339055581475 as (select id as v1, name as v43 from char_name as chn)
select movie_id as v31, note as v12, role_id as v29, v43 from cast_info as ci, aggView5034418339055581475 where ci.person_role_id=aggView5034418339055581475.v1 and note LIKE '%(producer)%');
create or replace view aggJoin2373085528775246115 as (
with aggView1412606579070449200 as (select id as v29 from role_type as rt where role= 'actor')
select v31, v12, v43 from aggJoin6590921452612200677 join aggView1412606579070449200 using(v29));
create or replace view aggJoin7236105867975076638 as (
with aggView4094430647100412291 as (select id as v22 from company_type as ct)
select v31, v15, v44 from aggJoin2535248781113983680 join aggView4094430647100412291 using(v22));
create or replace view aggJoin5306464943625736226 as (
with aggView4381108931834014505 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v31, v44 from aggJoin7236105867975076638 join aggView4381108931834014505 using(v15));
create or replace view aggJoin5196673000726610113 as (
with aggView6712263862504535428 as (select v31, MIN(v43) as v43 from aggJoin2373085528775246115 group by v31,v43)
select v44 as v44, v43 from aggJoin5306464943625736226 join aggView6712263862504535428 using(v31));
select MIN(v43) as v43,MIN(v44) as v44 from aggJoin5196673000726610113;
