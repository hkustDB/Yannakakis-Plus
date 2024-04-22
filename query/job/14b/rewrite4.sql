create or replace view aggJoin6884534580957939740 as (
with aggView3825327101574932268 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView3825327101574932268 where t.kind_id=aggView3825327101574932268.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggJoin2075151420590195503 as (
with aggView1702276031988819551 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView1702276031988819551 where mi_idx.info_type_id=aggView1702276031988819551.v3);
create or replace view aggJoin3065530413790892462 as (
with aggView1117736404506968223 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView1117736404506968223 where mi.info_type_id=aggView1117736404506968223.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin6054787919186216284 as (
with aggView1794238701261683715 as (select v23 from aggJoin3065530413790892462 group by v23)
select v23, v18 from aggJoin2075151420590195503 join aggView1794238701261683715 using(v23));
create or replace view aggJoin145865767159278117 as (
with aggView8152721520944058792 as (select v23, v18 from aggJoin6054787919186216284 group by v23,v18)
select v23, v18 from aggView8152721520944058792 where v18>'6.0');
create or replace view aggJoin5002709518541649667 as (
with aggView8122551861277853903 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select movie_id as v23 from movie_keyword as mk, aggView8122551861277853903 where mk.keyword_id=aggView8122551861277853903.v5);
create or replace view aggJoin2989578488008371926 as (
with aggView1497632692654054629 as (select v23 from aggJoin5002709518541649667 group by v23)
select v23, v24, v27 from aggJoin6884534580957939740 join aggView1497632692654054629 using(v23));
create or replace view aggView1233933360719268489 as select v23, v24 from aggJoin2989578488008371926 group by v23,v24;
create or replace view aggJoin1300990924553921388 as (
with aggView5031766176174078933 as (select v23, MIN(v18) as v35 from aggJoin145865767159278117 group by v23)
select v24, v35 from aggView1233933360719268489 join aggView5031766176174078933 using(v23));
select MIN(v35) as v35,MIN(v24) as v36 from aggJoin1300990924553921388;
