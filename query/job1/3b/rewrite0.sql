create or replace view aggView3043622330591691419 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6180376463471073383 as select movie_id as v12 from movie_keyword as mk, aggView3043622330591691419 where mk.keyword_id=aggView3043622330591691419.v1;
create or replace view aggView4028231746155103084 as select v12 from aggJoin6180376463471073383 group by v12;
create or replace view aggJoin8627885726980442485 as select id as v12, title as v13 from title as t, aggView4028231746155103084 where t.id=aggView4028231746155103084.v12 and production_year>2010;
create or replace view aggView5322831934113106259 as select v12, MIN(v13) as v24 from aggJoin8627885726980442485 group by v12;
create or replace view aggJoin6222316271636818764 as select v24 from movie_info as mi, aggView5322831934113106259 where mi.movie_id=aggView5322831934113106259.v12 and info= 'Bulgaria';
select MIN(v24) as v24 from aggJoin6222316271636818764;
