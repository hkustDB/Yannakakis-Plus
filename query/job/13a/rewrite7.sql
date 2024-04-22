create or replace view aggJoin4341963402887393633 as (
with aggView4478531861778869357 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView4478531861778869357 where mc.company_type_id=aggView4478531861778869357.v8);
create or replace view aggJoin5173709062914150810 as (
with aggView1140971541098206702 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView1140971541098206702 where miidx.info_type_id=aggView1140971541098206702.v10);
create or replace view aggView7847154943893385686 as select v22, v29 from aggJoin5173709062914150810 group by v22,v29;
create or replace view aggJoin8615036657634581852 as (
with aggView5435586290611439227 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22, info as v24 from movie_info as mi, aggView5435586290611439227 where mi.info_type_id=aggView5435586290611439227.v12);
create or replace view aggView8518429131619344590 as select v24, v22 from aggJoin8615036657634581852 group by v24,v22;
create or replace view aggJoin1578903064884952749 as (
with aggView7262394901036383978 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin4341963402887393633 join aggView7262394901036383978 using(v1));
create or replace view aggJoin69013218072042548 as (
with aggView1547917212362048886 as (select v22 from aggJoin1578903064884952749 group by v22)
select id as v22, title as v32, kind_id as v14 from title as t, aggView1547917212362048886 where t.id=aggView1547917212362048886.v22);
create or replace view aggJoin8214265782962325093 as (
with aggView9186380819379809429 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32 from aggJoin69013218072042548 join aggView9186380819379809429 using(v14));
create or replace view aggView4029567845683136138 as select v22, v32 from aggJoin8214265782962325093 group by v22,v32;
create or replace view aggJoin4664797560455867282 as (
with aggView2084707446260541427 as (select v22, MIN(v24) as v43 from aggView8518429131619344590 group by v22)
select v22, v32, v43 from aggView4029567845683136138 join aggView2084707446260541427 using(v22));
create or replace view aggJoin4980519309478037234 as (
with aggView6684730423804004086 as (select v22, MIN(v43) as v43, MIN(v32) as v45 from aggJoin4664797560455867282 group by v22,v43)
select v29, v43, v45 from aggView7847154943893385686 join aggView6684730423804004086 using(v22));
select MIN(v43) as v43,MIN(v29) as v44,MIN(v45) as v45 from aggJoin4980519309478037234;
