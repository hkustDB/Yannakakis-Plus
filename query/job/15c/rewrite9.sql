create or replace view aggJoin400622136312931927 as (
with aggView4538629628041322819 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView4538629628041322819 where mc.company_id=aggView4538629628041322819.v13);
create or replace view aggJoin4597480839244487548 as (
with aggView8095096254393702095 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView8095096254393702095 where mk.keyword_id=aggView8095096254393702095.v24);
create or replace view aggJoin2830558615351370362 as (
with aggView3898391203525702066 as (select id as v20 from company_type as ct)
select v40 from aggJoin400622136312931927 join aggView3898391203525702066 using(v20));
create or replace view aggJoin4608047466154940503 as (
with aggView7239608794677648033 as (select v40 from aggJoin4597480839244487548 group by v40)
select v40 from aggJoin2830558615351370362 join aggView7239608794677648033 using(v40));
create or replace view aggJoin2037002139674634750 as (
with aggView1328701200283842272 as (select v40 from aggJoin4608047466154940503 group by v40)
select movie_id as v40 from aka_title as aka_t, aggView1328701200283842272 where aka_t.movie_id=aggView1328701200283842272.v40);
create or replace view aggJoin8965840018563917397 as (
with aggView6644871999160121560 as (select v40 from aggJoin2037002139674634750 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView6644871999160121560 where t.id=aggView6644871999160121560.v40 and production_year>1990);
create or replace view aggView4912893183460179164 as select v41, v40 from aggJoin8965840018563917397 group by v41,v40;
create or replace view aggJoin8388513498593862037 as (
with aggView8832944127878632614 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView8832944127878632614 where mi.info_type_id=aggView8832944127878632614.v22 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggView3156096692271874750 as select v40, v35 from aggJoin8388513498593862037 group by v40,v35;
create or replace view aggJoin1814840219026959278 as (
with aggView3410436925694132870 as (select v40, MIN(v41) as v53 from aggView4912893183460179164 group by v40)
select v35, v53 from aggView3156096692271874750 join aggView3410436925694132870 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin1814840219026959278;
