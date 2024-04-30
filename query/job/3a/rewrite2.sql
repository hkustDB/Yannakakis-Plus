create or replace view aggView8149393931903817028 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin9056580654800164013 as select movie_id as v12 from movie_keyword as mk, aggView8149393931903817028 where mk.keyword_id=aggView8149393931903817028.v1;
create or replace view aggView5876047700881587449 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin3852462850620380442 as select v12 from aggJoin9056580654800164013 join aggView5876047700881587449 using(v12);
create or replace view aggView586187505960880877 as select v12 from aggJoin3852462850620380442 group by v12;
create or replace view aggJoin6381154592458933556 as select title as v13, production_year as v16 from title as t, aggView586187505960880877 where t.id=aggView586187505960880877.v12 and production_year>2005;
create or replace view aggView4760747209257107109 as select v13 from aggJoin6381154592458933556;
select MIN(v13) as v24 from aggView4760747209257107109;
