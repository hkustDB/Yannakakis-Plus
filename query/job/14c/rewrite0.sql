create or replace view aggJoin6577169580827856763 as (
with aggView7354176320214565701 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView7354176320214565701 where mk.keyword_id=aggView7354176320214565701.v5);
create or replace view aggJoin6008012502414745778 as (
with aggView8997979305261282943 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView8997979305261282943 where t.kind_id=aggView8997979305261282943.v8 and production_year>2005);
create or replace view aggJoin5673856179196467775 as (
with aggView4380602353012983824 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView4380602353012983824 where mi_idx.info_type_id=aggView4380602353012983824.v3 and info<'8.5');
create or replace view aggView3879791878443103937 as select v18, v23 from aggJoin5673856179196467775 group by v18,v23;
create or replace view aggJoin4552104160985817885 as (
with aggView251207958414951750 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView251207958414951750 where mi.info_type_id=aggView251207958414951750.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin4235276603310332136 as (
with aggView7669732028645019301 as (select v23 from aggJoin6577169580827856763 group by v23)
select v23, v13 from aggJoin4552104160985817885 join aggView7669732028645019301 using(v23));
create or replace view aggJoin5782516947857467213 as (
with aggView3223913515119378760 as (select v23 from aggJoin4235276603310332136 group by v23)
select v23, v24, v27 from aggJoin6008012502414745778 join aggView3223913515119378760 using(v23));
create or replace view aggView7030673598304566888 as select v24, v23 from aggJoin5782516947857467213 group by v24,v23;
create or replace view aggJoin6912509006838903283 as (
with aggView8280063513866969172 as (select v23, MIN(v24) as v36 from aggView7030673598304566888 group by v23)
select v18, v36 from aggView3879791878443103937 join aggView8280063513866969172 using(v23));
select MIN(v18) as v35,MIN(v36) as v36 from aggJoin6912509006838903283;
