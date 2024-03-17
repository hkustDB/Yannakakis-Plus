create or replace view aggView3149955530597560156 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin6548671675051056457 as select id as v12, title as v13 from title as t, aggView3149955530597560156 where t.id=aggView3149955530597560156.v12 and production_year>2005;
create or replace view aggView4688589757794324163 as select v12, MIN(v13) as v24 from aggJoin6548671675051056457 group by v12;
create or replace view aggJoin1067414335532766945 as select keyword_id as v1, v24 from movie_keyword as mk, aggView4688589757794324163 where mk.movie_id=aggView4688589757794324163.v12;
create or replace view aggView8901382310490938347 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3968262941616329169 as select v24 from aggJoin1067414335532766945 join aggView8901382310490938347 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin3968262941616329169;
select sum(v24) from res;