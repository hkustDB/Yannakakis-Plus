create or replace view aggView7587409419476415889 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin1928584731371239607 as select id as v12, title as v13 from title as t, aggView7587409419476415889 where t.id=aggView7587409419476415889.v12 and production_year>1990;
create or replace view aggView4244431753833086731 as select v12, MIN(v13) as v24 from aggJoin1928584731371239607 group by v12;
create or replace view aggJoin8177795371870526292 as select keyword_id as v1, v24 from movie_keyword as mk, aggView4244431753833086731 where mk.movie_id=aggView4244431753833086731.v12;
create or replace view aggView3082388946688194061 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4829421000606567543 as select v24 from aggJoin8177795371870526292 join aggView3082388946688194061 using(v1);
select MIN(v24) as v24 from aggJoin4829421000606567543;
