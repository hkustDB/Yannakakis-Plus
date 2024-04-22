create or replace view aggView7422890199118814203 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin8682298946164372003 as (
with aggView2554279515812961519 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView2554279515812961519 where mk.keyword_id=aggView2554279515812961519.v22);
create or replace view aggJoin3040866121427396134 as (
with aggView8540648168850669304 as (select v24 from aggJoin8682298946164372003 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView8540648168850669304 where t.id=aggView8540648168850669304.v24 and title LIKE '%Money%' and production_year= 1998);
create or replace view aggView8723837616594194851 as select v28, v24 from aggJoin3040866121427396134 group by v28,v24;
create or replace view aggJoin983277834943175783 as (
with aggView1598503546042207518 as (select v17, MIN(v2) as v39 from aggView7422890199118814203 group by v17)
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView1598503546042207518 where mc.company_id=aggView1598503546042207518.v17);
create or replace view aggJoin8719329347035297932 as (
with aggView1563571208362050208 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin983277834943175783 join aggView1563571208362050208 using(v18));
create or replace view aggJoin3484123007536226481 as (
with aggView3928349879545410197 as (select v24, MIN(v39) as v39 from aggJoin8719329347035297932 group by v24,v39)
select v28, v24, v39 from aggView8723837616594194851 join aggView3928349879545410197 using(v24));
create or replace view aggJoin508629476105864878 as (
with aggView5214680144805331625 as (select v24, MIN(v39) as v39, MIN(v28) as v41 from aggJoin3484123007536226481 group by v24,v39)
select link_type_id as v13, v39, v41 from movie_link as ml, aggView5214680144805331625 where ml.movie_id=aggView5214680144805331625.v24);
create or replace view aggJoin2839148739151205272 as (
with aggView5259908317615959100 as (select v13, MIN(v39) as v39, MIN(v41) as v41 from aggJoin508629476105864878 group by v13,v39,v41)
select link as v14, v39, v41 from link_type as lt, aggView5259908317615959100 where lt.id=aggView5259908317615959100.v13 and link LIKE '%follows%');
select MIN(v39) as v39,MIN(v14) as v40,MIN(v41) as v41 from aggJoin2839148739151205272;
