create or replace view aggView7015779402736024137 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin762783621159856643 as select id as v12, title as v13 from title as t, aggView7015779402736024137 where t.id=aggView7015779402736024137.v12 and production_year>2010;
create or replace view aggView7516828450172125736 as select v12, MIN(v13) as v24 from aggJoin762783621159856643 group by v12;
create or replace view aggJoin5700306355868491804 as select keyword_id as v1, v24 from movie_keyword as mk, aggView7516828450172125736 where mk.movie_id=aggView7516828450172125736.v12;
create or replace view aggView9168399574897518145 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5586019448691925688 as select v24 from aggJoin5700306355868491804 join aggView9168399574897518145 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin5586019448691925688;
select sum(v24) from res;