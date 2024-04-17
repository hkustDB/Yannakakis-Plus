create or replace view aggView1020254018272506494 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin7169571156095777070 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView1020254018272506494 where mi.movie_id=aggView1020254018272506494.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView3612054597411473654 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7267106526099902282 as select movie_id as v12 from movie_keyword as mk, aggView3612054597411473654 where mk.keyword_id=aggView3612054597411473654.v1;
create or replace view aggView2359324040986104982 as select v12 from aggJoin7267106526099902282 group by v12;
create or replace view aggJoin3336715191253627541 as select v24 as v24 from aggJoin7169571156095777070 join aggView2359324040986104982 using(v12);
select MIN(v24) as v24 from aggJoin3336715191253627541;
