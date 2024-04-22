create or replace view aggJoin6699282526560723028 as (
with aggView6565450927813992090 as (select id as v40, title as v53 from title as t where production_year>2000)
select movie_id as v40, company_id as v13, company_type_id as v20, note as v31, v53 from movie_companies as mc, aggView6565450927813992090 where mc.movie_id=aggView6565450927813992090.v40 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin7299712349906573997 as (
with aggView8028571781140936838 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView8028571781140936838 where mk.keyword_id=aggView8028571781140936838.v24);
create or replace view aggJoin2319171375130482968 as (
with aggView1174040041792590730 as (select id as v13 from company_name as cn where country_code= '[us]')
select v40, v20, v31, v53 from aggJoin6699282526560723028 join aggView1174040041792590730 using(v13));
create or replace view aggJoin8787164424246455122 as (
with aggView3764472514697201304 as (select id as v20 from company_type as ct)
select v40, v31, v53 from aggJoin2319171375130482968 join aggView3764472514697201304 using(v20));
create or replace view aggJoin1664867132055120592 as (
with aggView8858782776349441759 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView8858782776349441759 where mi.info_type_id=aggView8858782776349441759.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin3147779751972701061 as (
with aggView6093299058307198041 as (select v40, MIN(v35) as v52 from aggJoin1664867132055120592 group by v40)
select movie_id as v40, v52 from aka_title as aka_t, aggView6093299058307198041 where aka_t.movie_id=aggView6093299058307198041.v40);
create or replace view aggJoin4929875722294476391 as (
with aggView8327716660065332990 as (select v40, MIN(v52) as v52 from aggJoin3147779751972701061 group by v40,v52)
select v40, v31, v53 as v53, v52 from aggJoin8787164424246455122 join aggView8327716660065332990 using(v40));
create or replace view aggJoin6664905728014687883 as (
with aggView8564971499282664873 as (select v40, MIN(v53) as v53, MIN(v52) as v52 from aggJoin4929875722294476391 group by v40,v53,v52)
select v53, v52 from aggJoin7299712349906573997 join aggView8564971499282664873 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin6664905728014687883;
