create or replace view aggView4434955885614176220 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin2990564077646478757 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView4434955885614176220 where mi.movie_id=aggView4434955885614176220.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView19652686369319880 as select v12, MIN(v24) as v24 from aggJoin2990564077646478757 group by v12;
create or replace view aggJoin6769837890313207367 as select keyword_id as v1, v24 from movie_keyword as mk, aggView19652686369319880 where mk.movie_id=aggView19652686369319880.v12;
create or replace view aggView5318658281330277804 as select v1, MIN(v24) as v24 from aggJoin6769837890313207367 group by v1;
create or replace view aggJoin8240287468648792313 as select keyword as v2, v24 from keyword as k, aggView5318658281330277804 where k.id=aggView5318658281330277804.v1 and keyword LIKE '%sequel%';
select MIN(v24) as v24 from aggJoin8240287468648792313;
