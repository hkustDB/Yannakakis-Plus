create or replace view aggJoin721047923437208116 as (
with aggView7870600153713776260 as (select title as v28, id as v24 from title as t where production_year= 1998)
select v24, v28 from aggView7870600153713776260 where v28 LIKE '%Money%');
create or replace view aggView2562245176539240691 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin3265494481703526882 as (
with aggView7123481702617391250 as (select v17, MIN(v2) as v39 from aggView2562245176539240691 group by v17)
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView7123481702617391250 where mc.company_id=aggView7123481702617391250.v17);
create or replace view aggJoin8604472752946430636 as (
with aggView2127499601061095034 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView2127499601061095034 where mk.keyword_id=aggView2127499601061095034.v22);
create or replace view aggJoin5952497546325767954 as (
with aggView1636197661966810521 as (select v24 from aggJoin8604472752946430636 group by v24)
select movie_id as v24, link_type_id as v13 from movie_link as ml, aggView1636197661966810521 where ml.movie_id=aggView1636197661966810521.v24);
create or replace view aggJoin5915849810380817593 as (
with aggView7933008759229821694 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin3265494481703526882 join aggView7933008759229821694 using(v18));
create or replace view aggJoin5592633522302121419 as (
with aggView9090341864765617749 as (select v24, MIN(v39) as v39 from aggJoin5915849810380817593 group by v24,v39)
select v24, v28, v39 from aggJoin721047923437208116 join aggView9090341864765617749 using(v24));
create or replace view aggJoin7039205634856036854 as (
with aggView8777986545758407152 as (select v24, MIN(v39) as v39, MIN(v28) as v41 from aggJoin5592633522302121419 group by v24,v39)
select v13, v39, v41 from aggJoin5952497546325767954 join aggView8777986545758407152 using(v24));
create or replace view aggJoin5686759101882976629 as (
with aggView2628000964372563718 as (select v13, MIN(v39) as v39, MIN(v41) as v41 from aggJoin7039205634856036854 group by v13,v39,v41)
select link as v14, v39, v41 from link_type as lt, aggView2628000964372563718 where lt.id=aggView2628000964372563718.v13 and link LIKE '%follows%');
select MIN(v39) as v39,MIN(v14) as v40,MIN(v41) as v41 from aggJoin5686759101882976629;
