create or replace view aggView1189275428934518869 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin1453287899305698785 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView1189275428934518869 where mk.movie_id=aggView1189275428934518869.v12;
create or replace view aggView1482837855432672229 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1020122031693600422 as select v12, v24 from aggJoin1453287899305698785 join aggView1482837855432672229 using(v1);
create or replace view aggView8872181546811125435 as select v12, MIN(v24) as v24 from aggJoin1020122031693600422 group by v12;
create or replace view aggJoin5582347431020893581 as select info as v7, v24 from movie_info as mi, aggView8872181546811125435 where mi.movie_id=aggView8872181546811125435.v12 and info= 'Bulgaria';
create or replace view res as select MIN(v24) as v24 from aggJoin5582347431020893581;
select sum(v24) from res;