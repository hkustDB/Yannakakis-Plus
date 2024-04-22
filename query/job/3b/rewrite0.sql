create or replace view aggJoin7119534331136046282 as (
with aggView8338520652947949055 as (select id as v1 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v12 from movie_keyword as mk, aggView8338520652947949055 where mk.keyword_id=aggView8338520652947949055.v1);
create or replace view aggJoin6809661733523999092 as (
with aggView2851176804643416054 as (select v12 from aggJoin7119534331136046282 group by v12)
select movie_id as v12, info as v7 from movie_info as mi, aggView2851176804643416054 where mi.movie_id=aggView2851176804643416054.v12 and info= 'Bulgaria');
create or replace view aggJoin101982649442922836 as (
with aggView1392489362491086516 as (select v12 from aggJoin6809661733523999092 group by v12)
select title as v13, production_year as v16 from title as t, aggView1392489362491086516 where t.id=aggView1392489362491086516.v12 and production_year>2010);
create or replace view aggView8795942632297796819 as select v13 from aggJoin101982649442922836 group by v13;
select MIN(v13) as v24 from aggView8795942632297796819;
