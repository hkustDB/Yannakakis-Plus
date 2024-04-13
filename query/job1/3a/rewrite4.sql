create or replace view aggView4637125732961982737 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin979510187803050042 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView4637125732961982737 where mk.movie_id=aggView4637125732961982737.v12;
create or replace view aggView8522324674471082024 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6719020891048227050 as select v12, v24 from aggJoin979510187803050042 join aggView8522324674471082024 using(v1);
create or replace view aggView3447015255148498706 as select v12, MIN(v24) as v24 from aggJoin6719020891048227050 group by v12,v24;
create or replace view aggJoin2380830667939859589 as select v24 from movie_info as mi, aggView3447015255148498706 where mi.movie_id=aggView3447015255148498706.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
select MIN(v24) as v24 from aggJoin2380830667939859589;
