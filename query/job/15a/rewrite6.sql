create or replace view aggJoin5233818579673287372 as (
with aggView4814574854992067786 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView4814574854992067786 where mk.keyword_id=aggView4814574854992067786.v24);
create or replace view aggJoin7792616589853054781 as (
with aggView5196516415653697044 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView5196516415653697044 where mc.company_id=aggView5196516415653697044.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin3826449436263269861 as (
with aggView2744470586611535251 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select id as v40, title as v41, production_year as v44 from title as t, aggView2744470586611535251 where t.id=aggView2744470586611535251.v40 and production_year>2000);
create or replace view aggView1512472693307191064 as select v41, v40 from aggJoin3826449436263269861 group by v41,v40;
create or replace view aggJoin4061155374624214872 as (
with aggView13039307868938429 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin7792616589853054781 join aggView13039307868938429 using(v20));
create or replace view aggJoin4633903815884438482 as (
with aggView35734893543473589 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView35734893543473589 where mi.info_type_id=aggView35734893543473589.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin2239281933282362612 as (
with aggView1821726642563378768 as (select v40 from aggJoin5233818579673287372 group by v40)
select v40, v31 from aggJoin4061155374624214872 join aggView1821726642563378768 using(v40));
create or replace view aggJoin6037027319070117013 as (
with aggView3234146441752552465 as (select v40 from aggJoin2239281933282362612 group by v40)
select v40, v35, v36 from aggJoin4633903815884438482 join aggView3234146441752552465 using(v40));
create or replace view aggView4828306766161691985 as select v35, v40 from aggJoin6037027319070117013 group by v35,v40;
create or replace view aggJoin7642327080671666037 as (
with aggView1359896601039775178 as (select v40, MIN(v35) as v52 from aggView4828306766161691985 group by v40)
select v41, v52 from aggView1512472693307191064 join aggView1359896601039775178 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin7642327080671666037;
