create or replace view aggJoin6360644815714905190 as (
with aggView7498042019095202436 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView7498042019095202436 where mc.company_id=aggView7498042019095202436.v1);
create or replace view aggJoin8347773934475629605 as (
with aggView1041392106205823169 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin6360644815714905190 join aggView1041392106205823169 using(v8));
create or replace view aggJoin6785411376382540132 as (
with aggView6104471597524497769 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView6104471597524497769 where miidx.info_type_id=aggView6104471597524497769.v10);
create or replace view aggJoin677192852501002295 as (
with aggView8962398576492081086 as (select v22, MIN(v29) as v44 from aggJoin6785411376382540132 group by v22)
select id as v22, title as v32, kind_id as v14, v44 from title as t, aggView8962398576492081086 where t.id=aggView8962398576492081086.v22 and title<> '' and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggJoin2114471844862307881 as (
with aggView7081519023202951233 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView7081519023202951233 where mi.info_type_id=aggView7081519023202951233.v12);
create or replace view aggJoin5330164420294355846 as (
with aggView6623772267671698289 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32, v44 from aggJoin677192852501002295 join aggView6623772267671698289 using(v14));
create or replace view aggJoin5953047372996067511 as (
with aggView1459240147819537565 as (select v22, MIN(v44) as v44, MIN(v32) as v45 from aggJoin5330164420294355846 group by v22,v44)
select v22, v43 as v43, v44, v45 from aggJoin8347773934475629605 join aggView1459240147819537565 using(v22));
create or replace view aggJoin4714694094146431093 as (
with aggView9079081562942825339 as (select v22, MIN(v43) as v43, MIN(v44) as v44, MIN(v45) as v45 from aggJoin5953047372996067511 group by v22,v45,v44,v43)
select v43, v44, v45 from aggJoin2114471844862307881 join aggView9079081562942825339 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin4714694094146431093;
