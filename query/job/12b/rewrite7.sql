create or replace view aggView1864325612130570218 as select id as v29, title as v30 from title as t where production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%'));
create or replace view aggJoin100020047803727840 as (
with aggView8958944268271441548 as (select id as v21 from info_type as it1 where info= 'budget')
select movie_id as v29, info as v22 from movie_info as mi, aggView8958944268271441548 where mi.info_type_id=aggView8958944268271441548.v21);
create or replace view aggJoin6937424121565362492 as (
with aggView7970920873464475274 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView7970920873464475274 where mc.company_id=aggView7970920873464475274.v1);
create or replace view aggJoin8408221100790618494 as (
with aggView8203101378364545357 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin6937424121565362492 join aggView8203101378364545357 using(v8));
create or replace view aggJoin889943600233276523 as (
with aggView1757329320524816949 as (select v29 from aggJoin8408221100790618494 group by v29)
select movie_id as v29, info_type_id as v26 from movie_info_idx as mi_idx, aggView1757329320524816949 where mi_idx.movie_id=aggView1757329320524816949.v29);
create or replace view aggJoin9210315078226437001 as (
with aggView3052179044666112293 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select v29 from aggJoin889943600233276523 join aggView3052179044666112293 using(v26));
create or replace view aggJoin6961844396900645095 as (
with aggView8300225099407736489 as (select v29 from aggJoin9210315078226437001 group by v29)
select v29, v22 from aggJoin100020047803727840 join aggView8300225099407736489 using(v29));
create or replace view aggView7532418157443523236 as select v29, v22 from aggJoin6961844396900645095 group by v29,v22;
create or replace view aggJoin636493620953913428 as (
with aggView6603558408816030281 as (select v29, MIN(v30) as v42 from aggView1864325612130570218 group by v29)
select v22, v42 from aggView7532418157443523236 join aggView6603558408816030281 using(v29));
select MIN(v22) as v41,MIN(v42) as v42 from aggJoin636493620953913428;
