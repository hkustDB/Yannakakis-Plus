create or replace view aggView4396704455665978726 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin100410945043682933 as select movie_id as v23, v35 from movie_keyword as mk, aggView4396704455665978726 where mk.keyword_id=aggView4396704455665978726.v8;
create or replace view aggView1218055105990787035 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2713821903853425011 as select movie_id as v23, v36 from cast_info as ci, aggView1218055105990787035 where ci.person_id=aggView1218055105990787035.v14;
create or replace view aggView1983701352148041196 as select v23, MIN(v35) as v35 from aggJoin100410945043682933 group by v23,v35;
create or replace view aggJoin6769592642072300521 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView1983701352148041196 where t.id=aggView1983701352148041196.v23 and production_year>2014;
create or replace view aggView2411961125019523041 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin6769592642072300521 group by v23,v35;
create or replace view aggJoin3937181786399892157 as select v36 as v36, v35, v37 from aggJoin2713821903853425011 join aggView2411961125019523041 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3937181786399892157;
