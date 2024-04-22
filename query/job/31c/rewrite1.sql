create or replace view aggView7197400377512260756 as select id as v49, title as v50 from title as t;
create or replace view aggView1541838252196750180 as select name as v41, id as v40 from name as n;
create or replace view aggJoin6161204059225286673 as (
with aggView8460144822111377759 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView8460144822111377759 where mk.keyword_id=aggView8460144822111377759.v19);
create or replace view aggJoin604127741658322466 as (
with aggView5584734059029770836 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView5584734059029770836 where mc.company_id=aggView5584734059029770836.v8);
create or replace view aggJoin767655383590243329 as (
with aggView6097905909252176058 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView6097905909252176058 where mi.info_type_id=aggView6097905909252176058.v15);
create or replace view aggJoin960214318240243553 as (
with aggView8788127328441088250 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView8788127328441088250 where mi_idx.info_type_id=aggView8788127328441088250.v17);
create or replace view aggView7830966568653268761 as select v49, v35 from aggJoin960214318240243553 group by v49,v35;
create or replace view aggJoin8502859511514197757 as (
with aggView6572603401059114158 as (select v49 from aggJoin604127741658322466 group by v49)
select v49 from aggJoin6161204059225286673 join aggView6572603401059114158 using(v49));
create or replace view aggJoin3396279326148936947 as (
with aggView5166119830884594257 as (select v49 from aggJoin8502859511514197757 group by v49)
select v49, v30 from aggJoin767655383590243329 join aggView5166119830884594257 using(v49));
create or replace view aggJoin4813105166603815490 as (
with aggView574291736883999714 as (select v49, v30 from aggJoin3396279326148936947 group by v49,v30)
select v49, v30 from aggView574291736883999714 where v30 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin240090523306988183 as (
with aggView9212259681071541026 as (select v49, MIN(v30) as v61 from aggJoin4813105166603815490 group by v49)
select v49, v35, v61 from aggView7830966568653268761 join aggView9212259681071541026 using(v49));
create or replace view aggJoin7306887501041708177 as (
with aggView7651142799380917667 as (select v49, MIN(v61) as v61, MIN(v35) as v62 from aggJoin240090523306988183 group by v49,v61)
select v49, v50, v61, v62 from aggView7197400377512260756 join aggView7651142799380917667 using(v49));
create or replace view aggJoin6655662642265198255 as (
with aggView2470436966449053878 as (select v49, MIN(v61) as v61, MIN(v62) as v62, MIN(v50) as v64 from aggJoin7306887501041708177 group by v49,v61,v62)
select person_id as v40, note as v5, v61, v62, v64 from cast_info as ci, aggView2470436966449053878 where ci.movie_id=aggView2470436966449053878.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1370480063908694881 as (
with aggView5165723490608831917 as (select v40, MIN(v61) as v61, MIN(v62) as v62, MIN(v64) as v64 from aggJoin6655662642265198255 group by v40,v64,v61,v62)
select v41, v61, v62, v64 from aggView1541838252196750180 join aggView5165723490608831917 using(v40));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v41) as v63,MIN(v64) as v64 from aggJoin1370480063908694881;
