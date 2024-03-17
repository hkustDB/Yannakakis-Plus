create or replace view aggView7645419070439561800 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin131075989640119198 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView7645419070439561800 where mk.movie_id=aggView7645419070439561800.v12;
create or replace view aggView8615312759640014629 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin917541470324376771 as select v12, v24 from aggJoin131075989640119198 join aggView8615312759640014629 using(v1);
create or replace view aggView2919709307090077851 as select v12, MIN(v24) as v24 from aggJoin917541470324376771 group by v12;
create or replace view aggJoin7830705208632468616 as select info as v7, v24 from movie_info as mi, aggView2919709307090077851 where mi.movie_id=aggView2919709307090077851.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
select MIN(v24) as v24 from aggJoin7830705208632468616;
