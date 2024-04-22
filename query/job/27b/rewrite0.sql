create or replace view aggView2468091087316911568 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin1275439708771008464 as (
with aggView8001970621711865775 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView8001970621711865775 where mk.keyword_id=aggView8001970621711865775.v35);
create or replace view aggJoin9089445628899877350 as (
with aggView2887605739488749204 as (select v37 from aggJoin1275439708771008464 group by v37)
select movie_id as v37, info as v31 from movie_info as mi, aggView2887605739488749204 where mi.movie_id=aggView2887605739488749204.v37 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin3984074408405350489 as (
with aggView7670100774895046956 as (select v37 from aggJoin9089445628899877350 group by v37)
select id as v37, title as v41, production_year as v44 from title as t, aggView7670100774895046956 where t.id=aggView7670100774895046956.v37 and production_year= 1998);
create or replace view aggView1056762270164966823 as select v37, v41 from aggJoin3984074408405350489 group by v37,v41;
create or replace view aggJoin2675973113816426349 as (
with aggView1966834957057314961 as (select v25, MIN(v10) as v52 from aggView2468091087316911568 group by v25)
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView1966834957057314961 where mc.company_id=aggView1966834957057314961.v25);
create or replace view aggJoin3079088788760078466 as (
with aggView2647514739499465658 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView2647514739499465658 where ml.link_type_id=aggView2647514739499465658.v21);
create or replace view aggJoin5880397938648572992 as (
with aggView4846130481559757589 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView4846130481559757589 where cc.subject_id=aggView4846130481559757589.v5);
create or replace view aggJoin786891476110464944 as (
with aggView3098124826607444905 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin5880397938648572992 join aggView3098124826607444905 using(v7));
create or replace view aggJoin1897618511437911083 as (
with aggView7035798920272734923 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin2675973113816426349 join aggView7035798920272734923 using(v26));
create or replace view aggJoin5165443830878653729 as (
with aggView6163272869496356594 as (select v37, MIN(v52) as v52 from aggJoin1897618511437911083 group by v37,v52)
select v37, v53 as v53, v52 from aggJoin3079088788760078466 join aggView6163272869496356594 using(v37));
create or replace view aggJoin5226779248200595488 as (
with aggView2536951398619750826 as (select v37 from aggJoin786891476110464944 group by v37)
select v37, v53 as v53, v52 as v52 from aggJoin5165443830878653729 join aggView2536951398619750826 using(v37));
create or replace view aggJoin1880826836465963770 as (
with aggView8980959126366022656 as (select v37, MIN(v53) as v53, MIN(v52) as v52 from aggJoin5226779248200595488 group by v37,v53,v52)
select v41, v53, v52 from aggView1056762270164966823 join aggView8980959126366022656 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v41) as v54 from aggJoin1880826836465963770;
