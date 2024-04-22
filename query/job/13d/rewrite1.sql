create or replace view aggView5750484169910539650 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin4840229252582174046 as (
with aggView8061629950947808382 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView8061629950947808382 where t.kind_id=aggView8061629950947808382.v14);
create or replace view aggJoin8270787947909883449 as (
with aggView7830135306565728086 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView7830135306565728086 where mi.info_type_id=aggView7830135306565728086.v12);
create or replace view aggJoin7624288981661340636 as (
with aggView5265144750352581597 as (select v22 from aggJoin8270787947909883449 group by v22)
select v22, v32 from aggJoin4840229252582174046 join aggView5265144750352581597 using(v22));
create or replace view aggView7473348348462886411 as select v32, v22 from aggJoin7624288981661340636 group by v32,v22;
create or replace view aggJoin4838244991308404789 as (
with aggView5122856549783480695 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView5122856549783480695 where miidx.info_type_id=aggView5122856549783480695.v10);
create or replace view aggView5922471321098111248 as select v22, v29 from aggJoin4838244991308404789 group by v22,v29;
create or replace view aggJoin1866268181780687675 as (
with aggView5832110701604115593 as (select v22, MIN(v32) as v45 from aggView7473348348462886411 group by v22)
select v22, v29, v45 from aggView5922471321098111248 join aggView5832110701604115593 using(v22));
create or replace view aggJoin1731765864236709373 as (
with aggView3328508239796886837 as (select v22, MIN(v45) as v45, MIN(v29) as v44 from aggJoin1866268181780687675 group by v22,v45)
select company_id as v1, company_type_id as v8, v45, v44 from movie_companies as mc, aggView3328508239796886837 where mc.movie_id=aggView3328508239796886837.v22);
create or replace view aggJoin6799388492655055845 as (
with aggView6325211528331882864 as (select id as v8 from company_type as ct where kind= 'production companies')
select v1, v45, v44 from aggJoin1731765864236709373 join aggView6325211528331882864 using(v8));
create or replace view aggJoin4134400944295471685 as (
with aggView5674728700913716707 as (select v1, MIN(v45) as v45, MIN(v44) as v44 from aggJoin6799388492655055845 group by v1,v44,v45)
select v2, v45, v44 from aggView5750484169910539650 join aggView5674728700913716707 using(v1));
select MIN(v2) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin4134400944295471685;
