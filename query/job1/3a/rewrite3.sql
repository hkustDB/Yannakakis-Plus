create or replace view aggView8605505573568645978 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin116841032206162016 as select movie_id as v12 from movie_keyword as mk, aggView8605505573568645978 where mk.keyword_id=aggView8605505573568645978.v1;
create or replace view aggView4025437931504008731 as select v12 from aggJoin116841032206162016 group by v12;
create or replace view aggJoin5557098260684391033 as select id as v12, title as v13 from title as t, aggView4025437931504008731 where t.id=aggView4025437931504008731.v12 and production_year>2005;
create or replace view aggView4039448970784387557 as select v12, MIN(v13) as v24 from aggJoin5557098260684391033 group by v12;
create or replace view aggJoin5537898786037150509 as select v24 from movie_info as mi, aggView4039448970784387557 where mi.movie_id=aggView4039448970784387557.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view res as select MIN(v24) as v24 from aggJoin5537898786037150509;
select sum(v24) from res;