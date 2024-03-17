create or replace view aggView8348122942013572476 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin6260013893366607926 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView8348122942013572476 where mi.movie_id=aggView8348122942013572476.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView7785460439003408893 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4749553608553061129 as select movie_id as v12 from movie_keyword as mk, aggView7785460439003408893 where mk.keyword_id=aggView7785460439003408893.v1;
create or replace view aggView6393533896236418356 as select v12 from aggJoin4749553608553061129 group by v12;
create or replace view aggJoin8930742685474663106 as select v7, v24 as v24 from aggJoin6260013893366607926 join aggView6393533896236418356 using(v12);
create or replace view res as select MIN(v24) as v24 from aggJoin8930742685474663106;
select sum(v24) from res;