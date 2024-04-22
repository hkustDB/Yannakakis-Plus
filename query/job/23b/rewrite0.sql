create or replace view aggJoin2990114462590433954 as (
with aggView7049101624181632997 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView7049101624181632997 where mc.company_type_id=aggView7049101624181632997.v14);
create or replace view aggJoin6526923890902913672 as (
with aggView5835029588265335036 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView5835029588265335036 where mk.keyword_id=aggView5835029588265335036.v18);
create or replace view aggJoin6064454577167540792 as (
with aggView585872497492553664 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView585872497492553664 where mi.info_type_id=aggView585872497492553664.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin8240992460040430861 as (
with aggView2529170423071615881 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView2529170423071615881 where cc.status_id=aggView2529170423071615881.v5);
create or replace view aggJoin2276750541746562379 as (
with aggView3118583289097311389 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin2990114462590433954 join aggView3118583289097311389 using(v7));
create or replace view aggJoin5670980291563107273 as (
with aggView5305713638292167928 as (select v36 from aggJoin2276750541746562379 group by v36)
select v36 from aggJoin6526923890902913672 join aggView5305713638292167928 using(v36));
create or replace view aggJoin5198902121351465079 as (
with aggView3408917641725833577 as (select v36 from aggJoin5670980291563107273 group by v36)
select v36, v31, v32 from aggJoin6064454577167540792 join aggView3408917641725833577 using(v36));
create or replace view aggJoin7796149543424566052 as (
with aggView7206777964469762654 as (select v36 from aggJoin5198902121351465079 group by v36)
select v36 from aggJoin8240992460040430861 join aggView7206777964469762654 using(v36));
create or replace view aggJoin2570343437589365973 as (
with aggView5473687083343572499 as (select v36 from aggJoin7796149543424566052 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView5473687083343572499 where t.id=aggView5473687083343572499.v36 and production_year>2000);
create or replace view aggView7330426569650959666 as select v37, v21 from aggJoin2570343437589365973 group by v37,v21;
create or replace view aggJoin888514511970772427 as (
with aggView6434544919629916078 as (select v21, MIN(v37) as v49 from aggView7330426569650959666 group by v21)
select kind as v22, v49 from kind_type as kt, aggView6434544919629916078 where kt.id=aggView6434544919629916078.v21 and kind= 'movie');
select MIN(v22) as v48,MIN(v49) as v49 from aggJoin888514511970772427;
