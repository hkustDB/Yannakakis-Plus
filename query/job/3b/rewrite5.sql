create or replace view aggView1010492671896852305 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3556334619164771108 as select movie_id as v12 from movie_keyword as mk, aggView1010492671896852305 where mk.keyword_id=aggView1010492671896852305.v1;
create or replace view aggView3676497734188236589 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin1403875226561075028 as select v12 from aggJoin3556334619164771108 join aggView3676497734188236589 using(v12);
create or replace view aggView6627361434117738121 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin8327867919832997573 as select v24 from aggJoin1403875226561075028 join aggView6627361434117738121 using(v12);
select MIN(v24) as v24 from aggJoin8327867919832997573;
