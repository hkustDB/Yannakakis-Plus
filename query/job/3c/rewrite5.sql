create or replace view aggView4015014704444133661 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin655445303525829459 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView4015014704444133661 where mk.movie_id=aggView4015014704444133661.v12;
create or replace view aggView3357981854435881974 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2456680879894931893 as select v12, v24 from aggJoin655445303525829459 join aggView3357981854435881974 using(v1);
create or replace view aggView8226988278839431665 as select v12, MIN(v24) as v24 from aggJoin2456680879894931893 group by v12,v24;
create or replace view aggJoin1597011683724040614 as select v24 from movie_info as mi, aggView8226988278839431665 where mi.movie_id=aggView8226988278839431665.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
select MIN(v24) as v24 from aggJoin1597011683724040614;
