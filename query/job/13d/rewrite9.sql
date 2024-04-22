create or replace view aggView805144568287968075 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin3568501281101068936 as (
with aggView2400173884549801021 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView2400173884549801021 where t.kind_id=aggView2400173884549801021.v14);
create or replace view aggView428156567827560473 as select v32, v22 from aggJoin3568501281101068936 group by v32,v22;
create or replace view aggJoin5313400017288654844 as (
with aggView4531316571890577030 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView4531316571890577030 where mi.info_type_id=aggView4531316571890577030.v12);
create or replace view aggJoin8494765851882486458 as (
with aggView789350077621162013 as (select v22 from aggJoin5313400017288654844 group by v22)
select movie_id as v22, info_type_id as v10, info as v29 from movie_info_idx as miidx, aggView789350077621162013 where miidx.movie_id=aggView789350077621162013.v22);
create or replace view aggJoin6517852767888153423 as (
with aggView8033187698356461859 as (select id as v10 from info_type as it where info= 'rating')
select v22, v29 from aggJoin8494765851882486458 join aggView8033187698356461859 using(v10));
create or replace view aggView4006064643539871866 as select v22, v29 from aggJoin6517852767888153423 group by v22,v29;
create or replace view aggJoin3578277343528490067 as (
with aggView7362325497138807323 as (select v22, MIN(v29) as v44 from aggView4006064643539871866 group by v22)
select v32, v22, v44 from aggView428156567827560473 join aggView7362325497138807323 using(v22));
create or replace view aggJoin3822598688926249444 as (
with aggView4764159084843409373 as (select v1, MIN(v2) as v43 from aggView805144568287968075 group by v1)
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView4764159084843409373 where mc.company_id=aggView4764159084843409373.v1);
create or replace view aggJoin5374824795219258544 as (
with aggView6887914702367145666 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin3822598688926249444 join aggView6887914702367145666 using(v8));
create or replace view aggJoin2568034226048238758 as (
with aggView5386644024411870715 as (select v22, MIN(v43) as v43 from aggJoin5374824795219258544 group by v22,v43)
select v32, v44 as v44, v43 from aggJoin3578277343528490067 join aggView5386644024411870715 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin2568034226048238758;
