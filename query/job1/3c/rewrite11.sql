create or replace view aggView3220321949835884173 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin8493057795542120717 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView3220321949835884173 where mk.movie_id=aggView3220321949835884173.v12;
create or replace view aggView4627900515695674711 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin6381938195277698300 as select v1, v24 as v24 from aggJoin8493057795542120717 join aggView4627900515695674711 using(v12);
create or replace view aggView8983402708351122713 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5779458735758829966 as select v24 from aggJoin6381938195277698300 join aggView8983402708351122713 using(v1);
select MIN(v24) as v24 from aggJoin5779458735758829966;
