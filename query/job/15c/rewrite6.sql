create or replace view aggView8030627891375370391 as select title as v41, id as v40 from title as t where production_year>1990;
create or replace view aggJoin2175797572513260605 as (
with aggView7170519758064132988 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView7170519758064132988 where mc.company_id=aggView7170519758064132988.v13);
create or replace view aggJoin2144062505958620509 as (
with aggView5683139820114855646 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView5683139820114855646 where mk.keyword_id=aggView5683139820114855646.v24);
create or replace view aggJoin3589460029473169032 as (
with aggView6720298796748244844 as (select id as v20 from company_type as ct)
select v40 from aggJoin2175797572513260605 join aggView6720298796748244844 using(v20));
create or replace view aggJoin5430576614958409837 as (
with aggView6083631231608175606 as (select v40 from aggJoin2144062505958620509 group by v40)
select movie_id as v40, info_type_id as v22, info as v35, note as v36 from movie_info as mi, aggView6083631231608175606 where mi.movie_id=aggView6083631231608175606.v40 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggJoin1368283807199651047 as (
with aggView3000663439419978178 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select v40 from aggJoin3589460029473169032 join aggView3000663439419978178 using(v40));
create or replace view aggJoin3063801138635271516 as (
with aggView3765269263213664124 as (select v40 from aggJoin1368283807199651047 group by v40)
select v40, v22, v35, v36 from aggJoin5430576614958409837 join aggView3765269263213664124 using(v40));
create or replace view aggJoin6249505684903903826 as (
with aggView1667686094624955735 as (select id as v22 from info_type as it1 where info= 'release dates')
select v40, v35, v36 from aggJoin3063801138635271516 join aggView1667686094624955735 using(v22));
create or replace view aggView6844577439865493626 as select v40, v35 from aggJoin6249505684903903826 group by v40,v35;
create or replace view aggJoin8399142518110639290 as (
with aggView7640446633876313034 as (select v40, MIN(v35) as v52 from aggView6844577439865493626 group by v40)
select v41, v52 from aggView8030627891375370391 join aggView7640446633876313034 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin8399142518110639290;
