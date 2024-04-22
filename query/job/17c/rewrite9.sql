create or replace view aggJoin6909696772900788102 as (
with aggView7509666318929460364 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView7509666318929460364 where mk.keyword_id=aggView7509666318929460364.v25);
create or replace view aggJoin2724888705401017180 as (
with aggView6104565646354256861 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView6104565646354256861 where mc.company_id=aggView6104565646354256861.v20);
create or replace view aggJoin8083264335616228506 as (
with aggView5228166899399668218 as (select id as v3 from title as t)
select v3 from aggJoin6909696772900788102 join aggView5228166899399668218 using(v3));
create or replace view aggJoin5073902107593796452 as (
with aggView4499717979729020777 as (select v3 from aggJoin8083264335616228506 group by v3)
select v3 from aggJoin2724888705401017180 join aggView4499717979729020777 using(v3));
create or replace view aggJoin6096800889321890455 as (
with aggView9044064019048845730 as (select v3 from aggJoin5073902107593796452 group by v3)
select person_id as v26 from cast_info as ci, aggView9044064019048845730 where ci.movie_id=aggView9044064019048845730.v3);
create or replace view aggJoin869814572726294770 as (
with aggView3255660758377073846 as (select v26 from aggJoin6096800889321890455 group by v26)
select name as v27 from name as n, aggView3255660758377073846 where n.id=aggView3255660758377073846.v26 and name LIKE 'X%');
create or replace view aggView3490646651987589699 as select v27 from aggJoin869814572726294770 group by v27;
select MIN(v27) as v47 from aggView3490646651987589699;
