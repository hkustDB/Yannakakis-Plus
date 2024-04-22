create or replace view aggJoin6340699966855553008 as (
with aggView2294174093744044906 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView2294174093744044906 where mc.company_id=aggView2294174093744044906.v1);
create or replace view aggJoin6850676605813886867 as (
with aggView1058614429310538643 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin6340699966855553008 join aggView1058614429310538643 using(v8));
create or replace view aggJoin1755028032861866600 as (
with aggView6452230320932330868 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView6452230320932330868 where miidx.info_type_id=aggView6452230320932330868.v10);
create or replace view aggJoin7829371643823241522 as (
with aggView8764163177955914849 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView8764163177955914849 where mi.info_type_id=aggView8764163177955914849.v12);
create or replace view aggJoin1285571674550202720 as (
with aggView2854768015547394492 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView2854768015547394492 where t.kind_id=aggView2854768015547394492.v14 and title<> '' and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggJoin2629502975128290505 as (
with aggView674586245153410307 as (select v22, MIN(v43) as v43 from aggJoin6850676605813886867 group by v22,v43)
select v22, v29, v43 from aggJoin1755028032861866600 join aggView674586245153410307 using(v22));
create or replace view aggJoin8954288466285179173 as (
with aggView5039733756967240825 as (select v22, MIN(v43) as v43, MIN(v29) as v44 from aggJoin2629502975128290505 group by v22,v43)
select v22, v32, v43, v44 from aggJoin1285571674550202720 join aggView5039733756967240825 using(v22));
create or replace view aggJoin453122689540189911 as (
with aggView3658145413041657095 as (select v22, MIN(v43) as v43, MIN(v44) as v44, MIN(v32) as v45 from aggJoin8954288466285179173 group by v22,v44,v43)
select v43, v44, v45 from aggJoin7829371643823241522 join aggView3658145413041657095 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin453122689540189911;
