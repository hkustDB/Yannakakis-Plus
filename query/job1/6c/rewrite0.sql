create or replace view aggView8879022292760678407 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7518462714685865073 as select movie_id as v23, v35 from movie_keyword as mk, aggView8879022292760678407 where mk.keyword_id=aggView8879022292760678407.v8;
create or replace view aggView3884094421129895807 as select v23, MIN(v35) as v35 from aggJoin7518462714685865073 group by v23;
create or replace view aggJoin4153563538020739087 as select id as v23, title as v24, v35 from title as t, aggView3884094421129895807 where t.id=aggView3884094421129895807.v23 and production_year>2014;
create or replace view aggView718062640826174831 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin4153563538020739087 group by v23;
create or replace view aggJoin3853857804696651434 as select person_id as v14, v35, v37 from cast_info as ci, aggView718062640826174831 where ci.movie_id=aggView718062640826174831.v23;
create or replace view aggView2717240360359834508 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin3853857804696651434 group by v14;
create or replace view aggJoin5064852319803892372 as select name as v15, v35, v37 from name as n, aggView2717240360359834508 where n.id=aggView2717240360359834508.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin5064852319803892372;
