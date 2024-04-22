create or replace view aggJoin4642900987507949383 as (
with aggView5995263521578852015 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView5995263521578852015 where mc.company_id=aggView5995263521578852015.v23);
create or replace view aggJoin1169934805992067467 as (
with aggView8493316465638339237 as (select v53 from aggJoin4642900987507949383 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView8493316465638339237 where t.id=aggView8493316465638339237.v53 and production_year>2000);
create or replace view aggView4807835312275650779 as select v53, v54 from aggJoin1169934805992067467 group by v53,v54;
create or replace view aggJoin2244414409531264110 as (
with aggView3273801988501954795 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView3273801988501954795 where n.id=aggView3273801988501954795.v42 and name LIKE '%An%' and gender= 'f');
create or replace view aggView8849976746365236638 as select v43, v42 from aggJoin2244414409531264110 group by v43,v42;
create or replace view aggJoin4133864922644945771 as (
with aggView8404326864216737852 as (select v53, MIN(v54) as v66 from aggView4807835312275650779 group by v53)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView8404326864216737852 where ci.movie_id=aggView8404326864216737852.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin9197539144091095036 as (
with aggView6850185520852794555 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v53, v9, v20, v66 from aggJoin4133864922644945771 join aggView6850185520852794555 using(v51));
create or replace view aggJoin4715256395644241983 as (
with aggView1396440244886641426 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView1396440244886641426 where mi.info_type_id=aggView1396440244886641426.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin291997280535644925 as (
with aggView5441824606733537684 as (select v53 from aggJoin4715256395644241983 group by v53)
select v42, v9, v20, v66 as v66 from aggJoin9197539144091095036 join aggView5441824606733537684 using(v53));
create or replace view aggJoin6050675994111558652 as (
with aggView6028517262293792414 as (select id as v9 from char_name as chn)
select v42, v20, v66 from aggJoin291997280535644925 join aggView6028517262293792414 using(v9));
create or replace view aggJoin5281786557892982756 as (
with aggView5057516702046329149 as (select v42, MIN(v66) as v66 from aggJoin6050675994111558652 group by v42,v66)
select v43, v66 from aggView8849976746365236638 join aggView5057516702046329149 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin5281786557892982756;
