create or replace view aggJoin5424118683549622875 as (
with aggView8228642331508301954 as (select id as v31, title as v44 from title as t where production_year>1990)
select movie_id as v31, person_role_id as v1, note as v12, role_id as v29, v44 from cast_info as ci, aggView8228642331508301954 where ci.movie_id=aggView8228642331508301954.v31 and note LIKE '%(producer)%');
create or replace view aggJoin4560529357786754793 as (
with aggView3164278613606180558 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView3164278613606180558 where mc.company_type_id=aggView3164278613606180558.v22);
create or replace view aggJoin531856505005454302 as (
with aggView478149626416126106 as (select id as v29 from role_type as rt)
select v31, v1, v12, v44 from aggJoin5424118683549622875 join aggView478149626416126106 using(v29));
create or replace view aggJoin4889246345125057333 as (
with aggView6610809898176020797 as (select id as v15 from company_name as cn where country_code= '[us]')
select v31 from aggJoin4560529357786754793 join aggView6610809898176020797 using(v15));
create or replace view aggJoin3536238299441485454 as (
with aggView5226853422292251206 as (select v31 from aggJoin4889246345125057333 group by v31)
select v1, v12, v44 as v44 from aggJoin531856505005454302 join aggView5226853422292251206 using(v31));
create or replace view aggJoin1549774394900404621 as (
with aggView1235705163187154025 as (select v1, MIN(v44) as v44 from aggJoin3536238299441485454 group by v1,v44)
select name as v2, v44 from char_name as chn, aggView1235705163187154025 where chn.id=aggView1235705163187154025.v1);
select MIN(v2) as v43,MIN(v44) as v44 from aggJoin1549774394900404621;
