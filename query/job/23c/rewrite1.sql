create or replace view aggJoin4350117539605141957 as (
with aggView4421353096161292912 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView4421353096161292912 where mi.info_type_id=aggView4421353096161292912.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin729550878392423435 as (
with aggView1414531480952277443 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView1414531480952277443 where mk.keyword_id=aggView1414531480952277443.v18);
create or replace view aggJoin4746911406369047240 as (
with aggView2346466447827620340 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView2346466447827620340 where mc.company_type_id=aggView2346466447827620340.v14);
create or replace view aggJoin5160364106156089093 as (
with aggView2576335177040945093 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin4746911406369047240 join aggView2576335177040945093 using(v7));
create or replace view aggJoin1337084675951256629 as (
with aggView4103614809217874102 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView4103614809217874102 where cc.status_id=aggView4103614809217874102.v5);
create or replace view aggJoin1782234528722155627 as (
with aggView5218221612506944411 as (select v36 from aggJoin4350117539605141957 group by v36)
select id as v36, title as v37, kind_id as v21, production_year as v40 from title as t, aggView5218221612506944411 where t.id=aggView5218221612506944411.v36 and production_year>1990);
create or replace view aggJoin3842675756207711316 as (
with aggView7288401404888743009 as (select v36 from aggJoin5160364106156089093 group by v36)
select v36 from aggJoin1337084675951256629 join aggView7288401404888743009 using(v36));
create or replace view aggJoin3265960294439497324 as (
with aggView2404908306903285782 as (select v36 from aggJoin729550878392423435 group by v36)
select v36, v37, v21, v40 from aggJoin1782234528722155627 join aggView2404908306903285782 using(v36));
create or replace view aggJoin242079895723645197 as (
with aggView4540921460820612338 as (select v36 from aggJoin3842675756207711316 group by v36)
select v37, v21, v40 from aggJoin3265960294439497324 join aggView4540921460820612338 using(v36));
create or replace view aggView2288161827998433948 as select v37, v21 from aggJoin242079895723645197 group by v37,v21;
create or replace view aggJoin839803713730447371 as (
with aggView602126966014542895 as (select id as v21, kind as v48 from kind_type as kt where kind IN ('movie','tv movie','video movie','video game'))
select v37, v48 from aggView2288161827998433948 join aggView602126966014542895 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin839803713730447371;
