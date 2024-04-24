create or replace view aggView1669775371306271519 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4215682402107054800 as select movie_id as v23, v36 from cast_info as ci, aggView1669775371306271519 where ci.person_id=aggView1669775371306271519.v14;
create or replace view aggView4751820720764256022 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin1772615779805793890 as select movie_id as v23, v35 from movie_keyword as mk, aggView4751820720764256022 where mk.keyword_id=aggView4751820720764256022.v8;
create or replace view aggView6228922866017003803 as select v23, MIN(v35) as v35 from aggJoin1772615779805793890 group by v23,v35;
create or replace view aggJoin375974739007976035 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView6228922866017003803 where t.id=aggView6228922866017003803.v23 and production_year>2014;
create or replace view aggView6263936510257233834 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin375974739007976035 group by v23,v35;
create or replace view aggJoin3786042520960692330 as select v36 as v36, v35, v37 from aggJoin4215682402107054800 join aggView6263936510257233834 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3786042520960692330;
