create or replace view aggView342057140385146848 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin1113769993482492773 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView342057140385146848 where mk.movie_id=aggView342057140385146848.v12;
create or replace view aggView6150884903649773102 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin8360263575395417393 as select v1, v24 as v24 from aggJoin1113769993482492773 join aggView6150884903649773102 using(v12);
create or replace view aggView6060648935959478923 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6783715493952075668 as select v24 from aggJoin8360263575395417393 join aggView6060648935959478923 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin6783715493952075668;
select sum(v24) from res;