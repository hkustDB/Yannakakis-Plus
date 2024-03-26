create or replace view aggView3288231076270790255 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin7097729669020083140 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView3288231076270790255 where mi.movie_id=aggView3288231076270790255.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView5742880165768723976 as select v12, MIN(v24) as v24 from aggJoin7097729669020083140 group by v12;
create or replace view aggJoin9044086053351816059 as select keyword_id as v1, v24 from movie_keyword as mk, aggView5742880165768723976 where mk.movie_id=aggView5742880165768723976.v12;
create or replace view aggView1445452100718675324 as select v1, MIN(v24) as v24 from aggJoin9044086053351816059 group by v1;
create or replace view aggJoin7601544569764843341 as select keyword as v2, v24 from keyword as k, aggView1445452100718675324 where k.id=aggView1445452100718675324.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin7601544569764843341;
select sum(v24) from res;