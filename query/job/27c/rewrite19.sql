create or replace view aggView7746386048162472820 as select id as v37, title as v41 from title as t where production_year>=1950 and production_year<=2010;
create or replace view aggView2049285643740245380 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin6084731783679397973 as (
with aggView2671102483028342654 as (select v25, MIN(v10) as v52 from aggView2049285643740245380 group by v25)
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView2671102483028342654 where mc.company_id=aggView2671102483028342654.v25);
create or replace view aggJoin6442877079183853811 as (
with aggView6833125857567211701 as (select v37, MIN(v41) as v54 from aggView7746386048162472820 group by v37)
select v37, v26, v52 as v52, v54 from aggJoin6084731783679397973 join aggView6833125857567211701 using(v37));
create or replace view aggJoin6368556220628863171 as (
with aggView8144914544000688436 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView8144914544000688436 where mk.keyword_id=aggView8144914544000688436.v35);
create or replace view aggJoin3560689066639986466 as (
with aggView1694992739677162963 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView1694992739677162963 where cc.subject_id=aggView1694992739677162963.v5);
create or replace view aggJoin2905394965066779188 as (
with aggView7500497058604588968 as (select v37 from aggJoin6368556220628863171 group by v37)
select v37, v26, v52 as v52, v54 as v54 from aggJoin6442877079183853811 join aggView7500497058604588968 using(v37));
create or replace view aggJoin5649000631211214500 as (
with aggView91195726366659592 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin3560689066639986466 join aggView91195726366659592 using(v7));
create or replace view aggJoin4009703367099438365 as (
with aggView4504725314116973646 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select v37, v26, v52 as v52, v54 as v54 from aggJoin2905394965066779188 join aggView4504725314116973646 using(v37));
create or replace view aggJoin7330898818524219743 as (
with aggView1358892769672233915 as (select v37 from aggJoin5649000631211214500 group by v37)
select v37, v26, v52 as v52, v54 as v54 from aggJoin4009703367099438365 join aggView1358892769672233915 using(v37));
create or replace view aggJoin2245165447109849203 as (
with aggView4016476405392320245 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52, v54 from aggJoin7330898818524219743 join aggView4016476405392320245 using(v26));
create or replace view aggJoin2846724572523667804 as (
with aggView4437399643772011745 as (select v37, MIN(v52) as v52, MIN(v54) as v54 from aggJoin2245165447109849203 group by v37,v54,v52)
select link_type_id as v21, v52, v54 from movie_link as ml, aggView4437399643772011745 where ml.movie_id=aggView4437399643772011745.v37);
create or replace view aggJoin8649135809094054538 as (
with aggView6047211157287761447 as (select v21, MIN(v52) as v52, MIN(v54) as v54 from aggJoin2846724572523667804 group by v21,v54,v52)
select link as v22, v52, v54 from link_type as lt, aggView6047211157287761447 where lt.id=aggView6047211157287761447.v21 and link LIKE '%follow%');
select MIN(v52) as v52,MIN(v22) as v53,MIN(v54) as v54 from aggJoin8649135809094054538;
