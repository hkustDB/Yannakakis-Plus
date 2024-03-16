create or replace view aggView8705740442564641833 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin5087202791592837663 as select movie_id as v23, v36 from cast_info as ci, aggView8705740442564641833 where ci.person_id=aggView8705740442564641833.v14;
create or replace view aggView475541870741944533 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin6304400812750459423 as select v23, v36 from aggJoin5087202791592837663 join aggView475541870741944533 using(v23);
create or replace view aggView862562023518384092 as select v23, MIN(v36) as v36 from aggJoin6304400812750459423 group by v23;
create or replace view aggJoin2135293493865235596 as select keyword_id as v8, v36 from movie_keyword as mk, aggView862562023518384092 where mk.movie_id=aggView862562023518384092.v23;
create or replace view aggView994873650292203506 as select v8, MIN(v36) as v36 from aggJoin2135293493865235596 group by v8;
create or replace view aggJoin4320146564576045328 as select keyword as v9, v36 from keyword as k, aggView994873650292203506 where k.id=aggView994873650292203506.v8 and keyword= 'marvel-cinematic-universe';
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4320146564576045328;
