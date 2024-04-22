create or replace view aggJoin2174652259746669740 as (
with aggView3541212250696250789 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView3541212250696250789 where mk.keyword_id=aggView3541212250696250789.v18);
create or replace view aggJoin4620209363718341772 as (
with aggView485978622393206401 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView485978622393206401 where mc.company_type_id=aggView485978622393206401.v14);
create or replace view aggJoin5359774829652195790 as (
with aggView8706538514020123048 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView8706538514020123048 where mi.info_type_id=aggView8706538514020123048.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin6191185674397736043 as (
with aggView7649927766236307468 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView7649927766236307468 where cc.status_id=aggView7649927766236307468.v5);
create or replace view aggJoin5676425546956854974 as (
with aggView663912147921866227 as (select v36 from aggJoin2174652259746669740 group by v36)
select v36 from aggJoin6191185674397736043 join aggView663912147921866227 using(v36));
create or replace view aggJoin3144660111832730662 as (
with aggView7203449442571042093 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin4620209363718341772 join aggView7203449442571042093 using(v7));
create or replace view aggJoin32300543772746990 as (
with aggView1738567147591136206 as (select v36 from aggJoin5676425546956854974 group by v36)
select v36 from aggJoin3144660111832730662 join aggView1738567147591136206 using(v36));
create or replace view aggJoin4406032111883853895 as (
with aggView2330361372619695975 as (select v36 from aggJoin32300543772746990 group by v36)
select v36, v31, v32 from aggJoin5359774829652195790 join aggView2330361372619695975 using(v36));
create or replace view aggJoin1580709277822136704 as (
with aggView171674660797259367 as (select v36 from aggJoin4406032111883853895 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView171674660797259367 where t.id=aggView171674660797259367.v36 and production_year>2000);
create or replace view aggView1450925365402121568 as select v37, v21 from aggJoin1580709277822136704 group by v37,v21;
create or replace view aggJoin4539849464031883980 as (
with aggView7604549036335136664 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select v37, v48 from aggView1450925365402121568 join aggView7604549036335136664 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin4539849464031883980;
