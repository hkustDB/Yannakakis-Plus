create or replace view aggJoin5856239927165208871 as (
with aggView2142909983609744376 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView2142909983609744376 where mc.company_type_id=aggView2142909983609744376.v14);
create or replace view aggJoin5647238665719227675 as (
with aggView7537011848948047975 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView7537011848948047975 where mk.keyword_id=aggView7537011848948047975.v18);
create or replace view aggJoin3656949200236465907 as (
with aggView3832187221084056004 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView3832187221084056004 where mi.info_type_id=aggView3832187221084056004.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin6345034337631764617 as (
with aggView1907638532995167732 as (select v36 from aggJoin3656949200236465907 group by v36)
select v36, v7 from aggJoin5856239927165208871 join aggView1907638532995167732 using(v36));
create or replace view aggJoin1788095765043694669 as (
with aggView2695630818522736957 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView2695630818522736957 where cc.status_id=aggView2695630818522736957.v5);
create or replace view aggJoin6408727101877595140 as (
with aggView2159793979874850093 as (select v36 from aggJoin1788095765043694669 group by v36)
select id as v36, title as v37, kind_id as v21, production_year as v40 from title as t, aggView2159793979874850093 where t.id=aggView2159793979874850093.v36 and production_year>2000);
create or replace view aggJoin4056210342721972887 as (
with aggView6747389945346113824 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin6345034337631764617 join aggView6747389945346113824 using(v7));
create or replace view aggJoin2963919994452486637 as (
with aggView3883465811205183539 as (select v36 from aggJoin4056210342721972887 group by v36)
select v36 from aggJoin5647238665719227675 join aggView3883465811205183539 using(v36));
create or replace view aggJoin5934516145919443393 as (
with aggView4902909545434866531 as (select v36 from aggJoin2963919994452486637 group by v36)
select v37, v21, v40 from aggJoin6408727101877595140 join aggView4902909545434866531 using(v36));
create or replace view aggView7246898789447973691 as select v21, v37 from aggJoin5934516145919443393 group by v21,v37;
create or replace view aggJoin5998026279321024694 as (
with aggView4164786768729342422 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select v37, v48 from aggView7246898789447973691 join aggView4164786768729342422 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin5998026279321024694;
