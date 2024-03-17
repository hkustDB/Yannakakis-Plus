create or replace view aggView3265323916104131222 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin3481862172747975108 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView3265323916104131222 where mk.movie_id=aggView3265323916104131222.v12;
create or replace view aggView8152175269347915016 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin1180502242365305645 as select v1, v24 as v24 from aggJoin3481862172747975108 join aggView8152175269347915016 using(v12);
create or replace view aggView5887710568623901379 as select v1, MIN(v24) as v24 from aggJoin1180502242365305645 group by v1;
create or replace view aggJoin7829407119545591374 as select keyword as v2, v24 from keyword as k, aggView5887710568623901379 where k.id=aggView5887710568623901379.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin7829407119545591374;
select sum(v24) from res;