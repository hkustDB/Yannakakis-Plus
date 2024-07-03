create or replace view aggView3678767081243557388 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin9161176215007876127 as select movie_id as v23, v35 from movie_keyword as mk, aggView3678767081243557388 where mk.keyword_id=aggView3678767081243557388.v8;
create or replace view aggView3039439692792333120 as select v23, MIN(v35) as v35 from aggJoin9161176215007876127 group by v23,v35;
create or replace view aggJoin3286475356670745985 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView3039439692792333120 where t.id=aggView3039439692792333120.v23 and production_year>2010;
create or replace view aggView362238299075932690 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7841484933608605441 as select movie_id as v23, v36 from cast_info as ci, aggView362238299075932690 where ci.person_id=aggView362238299075932690.v14;
create or replace view aggView3018249707051875549 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin3286475356670745985 group by v23,v35;
create or replace view aggJoin6073346632027317682 as select v36 as v36, v35, v37 from aggJoin7841484933608605441 join aggView3018249707051875549 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6073346632027317682;
