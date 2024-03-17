create or replace view aggView8544383237211600401 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2265390804653951813 as select movie_id as v12 from movie_keyword as mk, aggView8544383237211600401 where mk.keyword_id=aggView8544383237211600401.v1;
create or replace view aggView7454771313991067170 as select v12 from aggJoin2265390804653951813 group by v12;
create or replace view aggJoin2327345204388839525 as select id as v12, title as v13 from title as t, aggView7454771313991067170 where t.id=aggView7454771313991067170.v12 and production_year>1990;
create or replace view aggView7766189154172093121 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin5613093453008442464 as select v13 from aggJoin2327345204388839525 join aggView7766189154172093121 using(v12);
create or replace view res as select MIN(v13) as v24 from aggJoin5613093453008442464;
select sum(v24) from res;