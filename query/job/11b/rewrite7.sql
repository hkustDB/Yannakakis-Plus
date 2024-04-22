create or replace view aggJoin4201164053728653238 as (
with aggView6801144294155772635 as (select title as v28, id as v24 from title as t where production_year= 1998)
select v24, v28 from aggView6801144294155772635 where v28 LIKE '%Money%');
create or replace view aggView4828788842190994904 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin9210345860671184386 as (
with aggView2405634215729551785 as (select v24, MIN(v28) as v41 from aggJoin4201164053728653238 group by v24)
select movie_id as v24, link_type_id as v13, v41 from movie_link as ml, aggView2405634215729551785 where ml.movie_id=aggView2405634215729551785.v24);
create or replace view aggJoin3276077433917633635 as (
with aggView5113373249364775895 as (select v17, MIN(v2) as v39 from aggView4828788842190994904 group by v17)
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView5113373249364775895 where mc.company_id=aggView5113373249364775895.v17);
create or replace view aggJoin8821298145421578802 as (
with aggView3835083730045718331 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView3835083730045718331 where mk.keyword_id=aggView3835083730045718331.v22);
create or replace view aggJoin4817723386263926524 as (
with aggView6094949914426321413 as (select v24 from aggJoin8821298145421578802 group by v24)
select v24, v18, v39 as v39 from aggJoin3276077433917633635 join aggView6094949914426321413 using(v24));
create or replace view aggJoin4225154553201511913 as (
with aggView1061567332920476762 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin4817723386263926524 join aggView1061567332920476762 using(v18));
create or replace view aggJoin3511477827995233595 as (
with aggView338622517358972265 as (select v24, MIN(v39) as v39 from aggJoin4225154553201511913 group by v24,v39)
select v13, v41 as v41, v39 from aggJoin9210345860671184386 join aggView338622517358972265 using(v24));
create or replace view aggJoin9145353874961892121 as (
with aggView275887724921367799 as (select v13, MIN(v41) as v41, MIN(v39) as v39 from aggJoin3511477827995233595 group by v13,v39,v41)
select link as v14, v41, v39 from link_type as lt, aggView275887724921367799 where lt.id=aggView275887724921367799.v13 and link LIKE '%follows%');
select MIN(v39) as v39,MIN(v14) as v40,MIN(v41) as v41 from aggJoin9145353874961892121;
