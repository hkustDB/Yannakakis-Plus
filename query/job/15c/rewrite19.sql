create or replace view aggJoin1792966253753384635 as (
with aggView8239189473344822807 as (select id as v40, title as v53 from title as t where production_year>1990)
select movie_id as v40, v53 from aka_title as aka_t, aggView8239189473344822807 where aka_t.movie_id=aggView8239189473344822807.v40);
create or replace view aggJoin1822225603384610703 as (
with aggView7151836617801670564 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView7151836617801670564 where mc.company_id=aggView7151836617801670564.v13);
create or replace view aggJoin2378559175717817140 as (
with aggView4749342882920919787 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView4749342882920919787 where mk.keyword_id=aggView4749342882920919787.v24);
create or replace view aggJoin1495583073639022251 as (
with aggView3754129728326596623 as (select id as v20 from company_type as ct)
select v40 from aggJoin1822225603384610703 join aggView3754129728326596623 using(v20));
create or replace view aggJoin7712999612370168314 as (
with aggView3010582839047993184 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView3010582839047993184 where mi.info_type_id=aggView3010582839047993184.v22 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggJoin5135402188609270821 as (
with aggView2554310416554802847 as (select v40, MIN(v35) as v52 from aggJoin7712999612370168314 group by v40)
select v40, v52 from aggJoin1495583073639022251 join aggView2554310416554802847 using(v40));
create or replace view aggJoin633224975391130212 as (
with aggView3256678431758712471 as (select v40, MIN(v53) as v53 from aggJoin1792966253753384635 group by v40,v53)
select v40, v52 as v52, v53 from aggJoin5135402188609270821 join aggView3256678431758712471 using(v40));
create or replace view aggJoin3489772753395465259 as (
with aggView6179251744974307344 as (select v40, MIN(v52) as v52, MIN(v53) as v53 from aggJoin633224975391130212 group by v40,v52,v53)
select v52, v53 from aggJoin2378559175717817140 join aggView6179251744974307344 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin3489772753395465259;
