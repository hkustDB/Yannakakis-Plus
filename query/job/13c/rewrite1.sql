create or replace view aggView8044382295361276575 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin6487833912339229873 as (
with aggView4232353680853990806 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView4232353680853990806 where miidx.info_type_id=aggView4232353680853990806.v10);
create or replace view aggJoin2607554352050807683 as (
with aggView5309577102324511041 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView5309577102324511041 where mi.info_type_id=aggView5309577102324511041.v12);
create or replace view aggJoin8857034456964886575 as (
with aggView1321765091002323792 as (select v22 from aggJoin2607554352050807683 group by v22)
select v22, v29 from aggJoin6487833912339229873 join aggView1321765091002323792 using(v22));
create or replace view aggView4677636702072199332 as select v22, v29 from aggJoin8857034456964886575 group by v22,v29;
create or replace view aggJoin4872187243490989090 as (
with aggView1993872978461359730 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView1993872978461359730 where t.kind_id=aggView1993872978461359730.v14 and title<> '' and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggView2855883226376747913 as select v32, v22 from aggJoin4872187243490989090 group by v32,v22;
create or replace view aggJoin1739770082843252764 as (
with aggView7702310942352306542 as (select v1, MIN(v2) as v43 from aggView8044382295361276575 group by v1)
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView7702310942352306542 where mc.company_id=aggView7702310942352306542.v1);
create or replace view aggJoin6101350688249089290 as (
with aggView8988379722686154268 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin1739770082843252764 join aggView8988379722686154268 using(v8));
create or replace view aggJoin5549888031976948196 as (
with aggView1815093733691274121 as (select v22, MIN(v43) as v43 from aggJoin6101350688249089290 group by v22,v43)
select v32, v22, v43 from aggView2855883226376747913 join aggView1815093733691274121 using(v22));
create or replace view aggJoin5994249763634657769 as (
with aggView926107287518173255 as (select v22, MIN(v43) as v43, MIN(v32) as v45 from aggJoin5549888031976948196 group by v22,v43)
select v29, v43, v45 from aggView4677636702072199332 join aggView926107287518173255 using(v22));
select MIN(v43) as v43,MIN(v29) as v44,MIN(v45) as v45 from aggJoin5994249763634657769;
