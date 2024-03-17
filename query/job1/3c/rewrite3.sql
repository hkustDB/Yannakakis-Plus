create or replace view aggView1163892014689775563 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin7000078083688085776 as select id as v12, title as v13 from title as t, aggView1163892014689775563 where t.id=aggView1163892014689775563.v12 and production_year>1990;
create or replace view aggView277025135988287240 as select v12, MIN(v13) as v24 from aggJoin7000078083688085776 group by v12;
create or replace view aggJoin5159375711091400939 as select keyword_id as v1, v24 from movie_keyword as mk, aggView277025135988287240 where mk.movie_id=aggView277025135988287240.v12;
create or replace view aggView2804485144675513540 as select v1, MIN(v24) as v24 from aggJoin5159375711091400939 group by v1;
create or replace view aggJoin2074255845334350062 as select v24 from keyword as k, aggView2804485144675513540 where k.id=aggView2804485144675513540.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin2074255845334350062;
select sum(v24) from res;