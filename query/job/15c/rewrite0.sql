create or replace view aggJoin2623012026625337429 as (
with aggView6368890786601008605 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView6368890786601008605 where mc.company_id=aggView6368890786601008605.v13);
create or replace view aggJoin9128662178075486251 as (
with aggView298260938519197720 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView298260938519197720 where mk.keyword_id=aggView298260938519197720.v24);
create or replace view aggJoin2423434164669070177 as (
with aggView5494792718233522910 as (select id as v20 from company_type as ct)
select v40 from aggJoin2623012026625337429 join aggView5494792718233522910 using(v20));
create or replace view aggJoin4518282925376911718 as (
with aggView6648901141134585205 as (select v40 from aggJoin2423434164669070177 group by v40)
select v40 from aggJoin9128662178075486251 join aggView6648901141134585205 using(v40));
create or replace view aggJoin8341931424224795724 as (
with aggView6126013294949596766 as (select v40 from aggJoin4518282925376911718 group by v40)
select movie_id as v40 from aka_title as aka_t, aggView6126013294949596766 where aka_t.movie_id=aggView6126013294949596766.v40);
create or replace view aggJoin811897100861076974 as (
with aggView1697091014563388461 as (select v40 from aggJoin8341931424224795724 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView1697091014563388461 where t.id=aggView1697091014563388461.v40 and production_year>1990);
create or replace view aggView8910567868279511799 as select v41, v40 from aggJoin811897100861076974 group by v41,v40;
create or replace view aggJoin1430594770024439445 as (
with aggView4291198841981776954 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView4291198841981776954 where mi.info_type_id=aggView4291198841981776954.v22 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggView8863891537457132641 as select v40, v35 from aggJoin1430594770024439445 group by v40,v35;
create or replace view aggJoin3224650441681783353 as (
with aggView3237598696158835823 as (select v40, MIN(v41) as v53 from aggView8910567868279511799 group by v40)
select v35, v53 from aggView8863891537457132641 join aggView3237598696158835823 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin3224650441681783353;
