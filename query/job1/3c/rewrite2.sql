create or replace view aggView443441185283944707 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin214789025687955561 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView443441185283944707 where mi.movie_id=aggView443441185283944707.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView5571469889429039182 as select v12, MIN(v24) as v24 from aggJoin214789025687955561 group by v12;
create or replace view aggJoin239100402586919847 as select keyword_id as v1, v24 from movie_keyword as mk, aggView5571469889429039182 where mk.movie_id=aggView5571469889429039182.v12;
create or replace view aggView1625077715233982258 as select v1, MIN(v24) as v24 from aggJoin239100402586919847 group by v1;
create or replace view aggJoin7381778336510326704 as select keyword as v2, v24 from keyword as k, aggView1625077715233982258 where k.id=aggView1625077715233982258.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin7381778336510326704;
select sum(v24) from res;