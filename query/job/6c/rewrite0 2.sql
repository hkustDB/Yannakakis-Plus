create or replace view aggView5940186469248171771 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin3779791463610143946 as select movie_id as v23, v35 from movie_keyword as mk, aggView5940186469248171771 where mk.keyword_id=aggView5940186469248171771.v8;
create or replace view aggView3396800553510936438 as select v23, MIN(v35) as v35 from aggJoin3779791463610143946 group by v23;
create or replace view aggJoin5435266703942025580 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView3396800553510936438 where t.id=aggView3396800553510936438.v23 and production_year>2014;
create or replace view aggView1850122241451450294 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin5435266703942025580 group by v23;
create or replace view aggJoin3935210839091009835 as select person_id as v14, v35, v37 from cast_info as ci, aggView1850122241451450294 where ci.movie_id=aggView1850122241451450294.v23;
create or replace view aggView2692348160791532827 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1036402836012626384 as select v35, v37, v36 from aggJoin3935210839091009835 join aggView2692348160791532827 using(v14);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1036402836012626384;
