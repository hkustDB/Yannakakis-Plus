create or replace view aggView7750292211422764132 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin1760753178280586155 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView7750292211422764132 where mi.movie_id=aggView7750292211422764132.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView3385800743612725770 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5638652248860646513 as select movie_id as v12 from movie_keyword as mk, aggView3385800743612725770 where mk.keyword_id=aggView3385800743612725770.v1;
create or replace view aggView7152832120683097340 as select v12 from aggJoin5638652248860646513 group by v12;
create or replace view aggJoin3880915367851819439 as select v7, v24 as v24 from aggJoin1760753178280586155 join aggView7152832120683097340 using(v12);
create or replace view res as select MIN(v24) as v24 from aggJoin3880915367851819439;
select sum(v24) from res;