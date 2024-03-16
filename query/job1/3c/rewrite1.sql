create or replace view aggView1318175041408451758 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6656178999118216501 as select movie_id as v12 from movie_keyword as mk, aggView1318175041408451758 where mk.keyword_id=aggView1318175041408451758.v1;
create or replace view aggView6271634726486711276 as select v12 from aggJoin6656178999118216501 group by v12;
create or replace view aggJoin4395659584255588609 as select id as v12, title as v13 from title as t, aggView6271634726486711276 where t.id=aggView6271634726486711276.v12 and production_year>1990;
create or replace view aggView5840160489117757091 as select v12, MIN(v13) as v24 from aggJoin4395659584255588609 group by v12;
create or replace view aggJoin5413039844729769813 as select v24 from movie_info as mi, aggView5840160489117757091 where mi.movie_id=aggView5840160489117757091.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view res as select MIN(v24) as v24 from aggJoin5413039844729769813;
select sum(v24) from res;