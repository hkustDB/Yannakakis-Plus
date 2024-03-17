create or replace view aggView7184092162226235760 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin6186249687304535915 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView7184092162226235760 where mk.movie_id=aggView7184092162226235760.v12;
create or replace view aggView3281561515468585872 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin9122526659315922852 as select v1, v24 as v24 from aggJoin6186249687304535915 join aggView3281561515468585872 using(v12);
create or replace view aggView5990313764384431341 as select v1, MIN(v24) as v24 from aggJoin9122526659315922852 group by v1;
create or replace view aggJoin6294801409705042924 as select keyword as v2, v24 from keyword as k, aggView5990313764384431341 where k.id=aggView5990313764384431341.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin6294801409705042924;
select sum(v24) from res;