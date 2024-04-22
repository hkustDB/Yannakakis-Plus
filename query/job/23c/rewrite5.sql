create or replace view aggJoin5000894278240525162 as (
with aggView3297146360694979229 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView3297146360694979229 where mi.info_type_id=aggView3297146360694979229.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin64022768754195164 as (
with aggView4315145753330582573 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView4315145753330582573 where mk.keyword_id=aggView4315145753330582573.v18);
create or replace view aggJoin1291590808019991243 as (
with aggView7242026844644887275 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView7242026844644887275 where mc.company_type_id=aggView7242026844644887275.v14);
create or replace view aggJoin4089465728773057792 as (
with aggView7966112041534921372 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin1291590808019991243 join aggView7966112041534921372 using(v7));
create or replace view aggJoin3252893914847082224 as (
with aggView2830077165972596731 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView2830077165972596731 where cc.status_id=aggView2830077165972596731.v5);
create or replace view aggJoin5025266069454484039 as (
with aggView1614926196480024393 as (select v36 from aggJoin64022768754195164 group by v36)
select v36 from aggJoin4089465728773057792 join aggView1614926196480024393 using(v36));
create or replace view aggJoin2561430005647894322 as (
with aggView9170808640290955080 as (select v36 from aggJoin5025266069454484039 group by v36)
select v36 from aggJoin3252893914847082224 join aggView9170808640290955080 using(v36));
create or replace view aggJoin7190515589372539458 as (
with aggView2904479902161031727 as (select v36 from aggJoin2561430005647894322 group by v36)
select v36, v31, v32 from aggJoin5000894278240525162 join aggView2904479902161031727 using(v36));
create or replace view aggJoin2932551283970899563 as (
with aggView7698732833094800008 as (select v36 from aggJoin7190515589372539458 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView7698732833094800008 where t.id=aggView7698732833094800008.v36 and production_year>1990);
create or replace view aggView2148810837267209326 as select v37, v21 from aggJoin2932551283970899563 group by v37,v21;
create or replace view aggJoin9188396743743914890 as (
with aggView8492763663218290426 as (select v21, MIN(v37) as v49 from aggView2148810837267209326 group by v21)
select kind as v22, v49 from kind_type as kt, aggView8492763663218290426 where kt.id=aggView8492763663218290426.v21 and kind IN ('movie','tv movie','video movie','video game'));
select MIN(v22) as v48,MIN(v49) as v49 from aggJoin9188396743743914890;
