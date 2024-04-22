create or replace view aggJoin6976058975414032435 as (
with aggView3417161276132388149 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView3417161276132388149 where cc.subject_id=aggView3417161276132388149.v5);
create or replace view aggJoin8590438150219968652 as (
with aggView6931505741380387252 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView6931505741380387252 where ci.person_id=aggView6931505741380387252.v31);
create or replace view aggJoin1153585361938531788 as (
with aggView7218021442232232271 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin6976058975414032435 join aggView7218021442232232271 using(v7));
create or replace view aggJoin2144396323304565611 as (
with aggView5122476994102961960 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView5122476994102961960 where t.kind_id=aggView5122476994102961960.v26 and production_year>1950);
create or replace view aggJoin4414752356260985232 as (
with aggView1339668597369502102 as (select v40, MIN(v41) as v52 from aggJoin2144396323304565611 group by v40)
select v40, v52 from aggJoin1153585361938531788 join aggView1339668597369502102 using(v40));
create or replace view aggJoin1371915515477774938 as (
with aggView9209273761829966070 as (select v40, MIN(v52) as v52 from aggJoin4414752356260985232 group by v40,v52)
select v40, v9, v52 from aggJoin8590438150219968652 join aggView9209273761829966070 using(v40));
create or replace view aggJoin7944179876924255813 as (
with aggView3789583249552163374 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40, v52 from aggJoin1371915515477774938 join aggView3789583249552163374 using(v9));
create or replace view aggJoin2455191053942542130 as (
with aggView6409438706885137776 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView6409438706885137776 where mk.keyword_id=aggView6409438706885137776.v23);
create or replace view aggJoin6500361745067762837 as (
with aggView5929826343718326828 as (select v40 from aggJoin2455191053942542130 group by v40)
select v52 as v52 from aggJoin7944179876924255813 join aggView5929826343718326828 using(v40));
select MIN(v52) as v52 from aggJoin6500361745067762837;
