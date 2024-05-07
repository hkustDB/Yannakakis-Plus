create or replace view aggView5099025864978003510 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7586515608359438303 as select movie_id as v12 from movie_keyword as mk, aggView5099025864978003510 where mk.keyword_id=aggView5099025864978003510.v1;
create or replace view aggView8599644795884786415 as select v12 from aggJoin7586515608359438303 group by v12;
create or replace view aggJoin1226300062881397576 as select movie_id as v12, info as v7 from movie_info as mi, aggView8599644795884786415 where mi.movie_id=aggView8599644795884786415.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView6890594963603022589 as select v12 from aggJoin1226300062881397576 group by v12;
create or replace view aggJoin5065290883359862977 as select title as v13, production_year as v16 from title as t, aggView6890594963603022589 where t.id=aggView6890594963603022589.v12 and production_year>1990;
create or replace view aggView2302247934387463734 as select v13 from aggJoin5065290883359862977;
select MIN(v13) as v24 from aggView2302247934387463734;
