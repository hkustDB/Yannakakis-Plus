create or replace view aggView8916680144351142923 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin671199943314927150 as select movie_id as v12 from movie_keyword as mk, aggView8916680144351142923 where mk.keyword_id=aggView8916680144351142923.v1;
create or replace view aggView7054396764846407292 as select v12 from aggJoin671199943314927150 group by v12;
create or replace view aggJoin5114631711246713340 as select id as v12, title as v13, production_year as v16 from title as t, aggView7054396764846407292 where t.id=aggView7054396764846407292.v12 and production_year>1990;
create or replace view aggView7678809880806676430 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin2239461920307753806 as select v13 from aggJoin5114631711246713340 join aggView7678809880806676430 using(v12);
select MIN(v13) as v24 from aggJoin2239461920307753806;
