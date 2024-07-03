create or replace view aggView6146009880870930175 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin3592587259648592919 as select movie_id as v23, v35 from movie_keyword as mk, aggView6146009880870930175 where mk.keyword_id=aggView6146009880870930175.v8;
create or replace view aggView7987096275469366696 as select v23, MIN(v35) as v35 from aggJoin3592587259648592919 group by v23,v35;
create or replace view aggJoin3488014894641592124 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView7987096275469366696 where t.id=aggView7987096275469366696.v23 and production_year>2014;
create or replace view aggView6011410535800620303 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin3488014894641592124 group by v23,v35;
create or replace view aggJoin5798429560153598750 as select person_id as v14, v35, v37 from cast_info as ci, aggView6011410535800620303 where ci.movie_id=aggView6011410535800620303.v23;
create or replace view aggView673727265173166855 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2585638455547906727 as select v35, v37, v36 from aggJoin5798429560153598750 join aggView673727265173166855 using(v14);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin2585638455547906727;
