create or replace view aggView6239743340791918404 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1701935154948430191 as select movie_id as v12 from movie_keyword as mk, aggView6239743340791918404 where mk.keyword_id=aggView6239743340791918404.v1;
create or replace view aggView268402070524832072 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin880631570579312511 as select id as v12, title as v13, production_year as v16 from title as t, aggView268402070524832072 where t.id=aggView268402070524832072.v12 and production_year>2005;
create or replace view aggView6271522249588023064 as select v12 from aggJoin1701935154948430191 group by v12;
create or replace view aggJoin5169287103322011520 as select v13, v16 from aggJoin880631570579312511 join aggView6271522249588023064 using(v12);
create or replace view aggView9140775772258306448 as select v13 from aggJoin5169287103322011520;
select MIN(v13) as v24 from aggView9140775772258306448;
