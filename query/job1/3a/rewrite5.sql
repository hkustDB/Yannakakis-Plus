create or replace view aggView6899190566043353788 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin6792658280830103535 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView6899190566043353788 where mk.movie_id=aggView6899190566043353788.v12;
create or replace view aggView3572416022640317151 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3150897238024783309 as select v12, v24 from aggJoin6792658280830103535 join aggView3572416022640317151 using(v1);
create or replace view aggView6517555454829430613 as select v12, MIN(v24) as v24 from aggJoin3150897238024783309 group by v12;
create or replace view aggJoin2470051576229983156 as select info as v7, v24 from movie_info as mi, aggView6517555454829430613 where mi.movie_id=aggView6517555454829430613.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view res as select MIN(v24) as v24 from aggJoin2470051576229983156;
select sum(v24) from res;