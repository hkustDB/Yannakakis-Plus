create or replace view aggView8159710374972137983 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin7432126756974207034 as (
with aggView135160332832862099 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView135160332832862099 where mk.keyword_id=aggView135160332832862099.v35);
create or replace view aggJoin2630771913367679485 as (
with aggView1111324970233261675 as (select v37 from aggJoin7432126756974207034 group by v37)
select movie_id as v37, info as v31 from movie_info as mi, aggView1111324970233261675 where mi.movie_id=aggView1111324970233261675.v37 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English'));
create or replace view aggJoin2479147695485349828 as (
with aggView4141966619585224091 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView4141966619585224091 where cc.subject_id=aggView4141966619585224091.v5);
create or replace view aggJoin4700808274066679747 as (
with aggView966857219366445526 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin2479147695485349828 join aggView966857219366445526 using(v7));
create or replace view aggJoin4147033251768528606 as (
with aggView1756335161761806269 as (select v37 from aggJoin2630771913367679485 group by v37)
select v37 from aggJoin4700808274066679747 join aggView1756335161761806269 using(v37));
create or replace view aggJoin1845233710611745000 as (
with aggView2912650095089453827 as (select v37 from aggJoin4147033251768528606 group by v37)
select id as v37, title as v41, production_year as v44 from title as t, aggView2912650095089453827 where t.id=aggView2912650095089453827.v37 and production_year>=1950 and production_year<=2010);
create or replace view aggView8788340933323299287 as select v37, v41 from aggJoin1845233710611745000 group by v37,v41;
create or replace view aggJoin276933838303937637 as (
with aggView2588931026478975271 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView2588931026478975271 where ml.link_type_id=aggView2588931026478975271.v21);
create or replace view aggJoin6577635649609227676 as (
with aggView8751550525326006344 as (select v37, MIN(v41) as v54 from aggView8788340933323299287 group by v37)
select movie_id as v37, company_id as v25, company_type_id as v26, v54 from movie_companies as mc, aggView8751550525326006344 where mc.movie_id=aggView8751550525326006344.v37);
create or replace view aggJoin6456494705231940415 as (
with aggView7635351092482450038 as (select v37, MIN(v53) as v53 from aggJoin276933838303937637 group by v37,v53)
select v25, v26, v54 as v54, v53 from aggJoin6577635649609227676 join aggView7635351092482450038 using(v37));
create or replace view aggJoin7244475671184929343 as (
with aggView3430244903733192577 as (select id as v26 from company_type as ct where kind= 'production companies')
select v25, v54, v53 from aggJoin6456494705231940415 join aggView3430244903733192577 using(v26));
create or replace view aggJoin9115740696075024908 as (
with aggView2821650549121024829 as (select v25, MIN(v54) as v54, MIN(v53) as v53 from aggJoin7244475671184929343 group by v25,v54,v53)
select v10, v54, v53 from aggView8159710374972137983 join aggView2821650549121024829 using(v25));
select MIN(v10) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin9115740696075024908;
