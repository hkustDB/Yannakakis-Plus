create or replace view aggView8246777319775000007 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin9013704675211156781 as (
with aggView3780055073586602801 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView3780055073586602801 where mi_idx.info_type_id=aggView3780055073586602801.v12 and info<'7.0');
create or replace view aggView2209378120181887158 as select v37, v32 from aggJoin9013704675211156781 group by v37,v32;
create or replace view aggJoin4900143087095354915 as (
with aggView5254745587212470097 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView5254745587212470097 where t.kind_id=aggView5254745587212470097.v17 and production_year>2009);
create or replace view aggJoin8518030751699072694 as (
with aggView6427025865236763615 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView6427025865236763615 where mi.info_type_id=aggView6427025865236763615.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin2353661929215627777 as (
with aggView4887524728942717393 as (select v37 from aggJoin8518030751699072694 group by v37)
select movie_id as v37, keyword_id as v14 from movie_keyword as mk, aggView4887524728942717393 where mk.movie_id=aggView4887524728942717393.v37);
create or replace view aggJoin2191480459388222224 as (
with aggView9048578062024800361 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v37 from aggJoin2353661929215627777 join aggView9048578062024800361 using(v14));
create or replace view aggJoin6362994530606426155 as (
with aggView1562494530500327851 as (select v37 from aggJoin2191480459388222224 group by v37)
select v37, v38, v41 from aggJoin4900143087095354915 join aggView1562494530500327851 using(v37));
create or replace view aggView8854578987053496550 as select v38, v37 from aggJoin6362994530606426155 group by v38,v37;
create or replace view aggJoin1940498689676917453 as (
with aggView4101328003597490692 as (select v37, MIN(v38) as v51 from aggView8854578987053496550 group by v37)
select v37, v32, v51 from aggView2209378120181887158 join aggView4101328003597490692 using(v37));
create or replace view aggJoin388196548918268444 as (
with aggView863569982467484082 as (select v37, MIN(v51) as v51, MIN(v32) as v50 from aggJoin1940498689676917453 group by v37,v51)
select company_id as v1, company_type_id as v8, note as v23, v51, v50 from movie_companies as mc, aggView863569982467484082 where mc.movie_id=aggView863569982467484082.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin9034526459052632094 as (
with aggView758342987387397043 as (select id as v8 from company_type as ct)
select v1, v23, v51, v50 from aggJoin388196548918268444 join aggView758342987387397043 using(v8));
create or replace view aggJoin1688481757040236711 as (
with aggView1302790070386437550 as (select v1, MIN(v51) as v51, MIN(v50) as v50 from aggJoin9034526459052632094 group by v1,v50,v51)
select v2, v51, v50 from aggView8246777319775000007 join aggView1302790070386437550 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin1688481757040236711;
