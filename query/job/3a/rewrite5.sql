create or replace view aggView6735065476417500754 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6267993792203034882 as select movie_id as v12 from movie_keyword as mk, aggView6735065476417500754 where mk.keyword_id=aggView6735065476417500754.v1;
create or replace view aggView8515278013358251808 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin2281937274444481129 as select v12 from aggJoin6267993792203034882 join aggView8515278013358251808 using(v12);
create or replace view aggView7054387013614102222 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin6114246833106680537 as select v24 from aggJoin2281937274444481129 join aggView7054387013614102222 using(v12);
select MIN(v24) as v24 from aggJoin6114246833106680537;
