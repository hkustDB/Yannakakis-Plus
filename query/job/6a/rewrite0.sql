create or replace view aggView4488541082599285969 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin1744684397696401940 as select movie_id as v23, v35 from movie_keyword as mk, aggView4488541082599285969 where mk.keyword_id=aggView4488541082599285969.v8;
create or replace view aggView8860552110034230920 as select v23, MIN(v35) as v35 from aggJoin1744684397696401940 group by v23;
create or replace view aggJoin5848770633777910033 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView8860552110034230920 where t.id=aggView8860552110034230920.v23 and production_year>2010;
create or replace view aggView4938753160568601743 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin5848770633777910033 group by v23;
create or replace view aggJoin4521897991648597616 as select person_id as v14, v35, v37 from cast_info as ci, aggView4938753160568601743 where ci.movie_id=aggView4938753160568601743.v23;
create or replace view aggView1634183913783959228 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin4521897991648597616 group by v14;
create or replace view aggJoin2802836156413305016 as select name as v15, v35, v37 from name as n, aggView1634183913783959228 where n.id=aggView1634183913783959228.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin2802836156413305016;
