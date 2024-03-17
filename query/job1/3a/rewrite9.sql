create or replace view aggView7347775303884584197 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin770695550600521741 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView7347775303884584197 where mk.movie_id=aggView7347775303884584197.v12;
create or replace view aggView8290066426930281362 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin8515280972356139622 as select v1, v24 as v24 from aggJoin770695550600521741 join aggView8290066426930281362 using(v12);
create or replace view aggView3141075426118285862 as select v1, MIN(v24) as v24 from aggJoin8515280972356139622 group by v1;
create or replace view aggJoin6766471037981999129 as select keyword as v2, v24 from keyword as k, aggView3141075426118285862 where k.id=aggView3141075426118285862.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin6766471037981999129;
select sum(v24) from res;