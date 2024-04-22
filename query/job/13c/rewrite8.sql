create or replace view aggView4757134459261731631 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin6203375544067962363 as (
with aggView1577761951072278051 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView1577761951072278051 where miidx.info_type_id=aggView1577761951072278051.v10);
create or replace view aggView4656469640991458393 as select v22, v29 from aggJoin6203375544067962363 group by v22,v29;
create or replace view aggJoin2259808604370500338 as (
with aggView5314553827515262799 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView5314553827515262799 where t.kind_id=aggView5314553827515262799.v14 and title<> '' and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggView3291917718703451832 as select v32, v22 from aggJoin2259808604370500338 group by v32,v22;
create or replace view aggJoin8437918201837230412 as (
with aggView5748644794452648565 as (select v1, MIN(v2) as v43 from aggView4757134459261731631 group by v1)
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView5748644794452648565 where mc.company_id=aggView5748644794452648565.v1);
create or replace view aggJoin8121533671063384422 as (
with aggView1122451366506948742 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin8437918201837230412 join aggView1122451366506948742 using(v8));
create or replace view aggJoin5333330751033304999 as (
with aggView6526693465307861554 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView6526693465307861554 where mi.info_type_id=aggView6526693465307861554.v12);
create or replace view aggJoin21689104796400848 as (
with aggView558067878445069251 as (select v22 from aggJoin5333330751033304999 group by v22)
select v22, v43 as v43 from aggJoin8121533671063384422 join aggView558067878445069251 using(v22));
create or replace view aggJoin4227667137293617499 as (
with aggView1701386230647643235 as (select v22, MIN(v43) as v43 from aggJoin21689104796400848 group by v22,v43)
select v22, v29, v43 from aggView4656469640991458393 join aggView1701386230647643235 using(v22));
create or replace view aggJoin4064099460673088776 as (
with aggView3927869445967766923 as (select v22, MIN(v43) as v43, MIN(v29) as v44 from aggJoin4227667137293617499 group by v22,v43)
select v32, v43, v44 from aggView3291917718703451832 join aggView3927869445967766923 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin4064099460673088776;
