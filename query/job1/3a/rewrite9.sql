create or replace view aggView5014210979054789355 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin1949433134946412556 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView5014210979054789355 where mi.movie_id=aggView5014210979054789355.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView1804889257574693275 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3259547776161910619 as select movie_id as v12 from movie_keyword as mk, aggView1804889257574693275 where mk.keyword_id=aggView1804889257574693275.v1;
create or replace view aggView4427553386186924109 as select v12 from aggJoin3259547776161910619 group by v12;
create or replace view aggJoin3368865494708483331 as select v7, v24 as v24 from aggJoin1949433134946412556 join aggView4427553386186924109 using(v12);
create or replace view res as select MIN(v24) as v24 from aggJoin3368865494708483331;
select sum(v24) from res;