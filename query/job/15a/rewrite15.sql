create or replace view aggJoin1591728760171099364 as (
with aggView8217099817742631695 as (select id as v40, title as v53 from title as t where production_year>2000)
select movie_id as v40, keyword_id as v24, v53 from movie_keyword as mk, aggView8217099817742631695 where mk.movie_id=aggView8217099817742631695.v40);
create or replace view aggJoin8146399498998671350 as (
with aggView3546142038421562886 as (select id as v24 from keyword as k)
select v40, v53 from aggJoin1591728760171099364 join aggView3546142038421562886 using(v24));
create or replace view aggJoin1839617812434514724 as (
with aggView8078460367133799853 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView8078460367133799853 where mc.company_id=aggView8078460367133799853.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin6752068219608710604 as (
with aggView5254427450235138126 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin1839617812434514724 join aggView5254427450235138126 using(v20));
create or replace view aggJoin8026868437908158054 as (
with aggView3041260246391146855 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView3041260246391146855 where mi.info_type_id=aggView3041260246391146855.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin153085071138120020 as (
with aggView6799487110319578643 as (select v40, MIN(v35) as v52 from aggJoin8026868437908158054 group by v40)
select v40, v31, v52 from aggJoin6752068219608710604 join aggView6799487110319578643 using(v40));
create or replace view aggJoin2408256007670400533 as (
with aggView749203977288128678 as (select v40, MIN(v52) as v52 from aggJoin153085071138120020 group by v40,v52)
select movie_id as v40, v52 from aka_title as aka_t, aggView749203977288128678 where aka_t.movie_id=aggView749203977288128678.v40);
create or replace view aggJoin4136828841166073548 as (
with aggView9211063881055269227 as (select v40, MIN(v52) as v52 from aggJoin2408256007670400533 group by v40,v52)
select v53 as v53, v52 from aggJoin8146399498998671350 join aggView9211063881055269227 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin4136828841166073548;
