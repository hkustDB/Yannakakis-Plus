create or replace view aggView653832548134678158 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin5457616418441773884 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView653832548134678158 where mk.movie_id=aggView653832548134678158.v12;
create or replace view aggView3790912183496765036 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3418856432240719651 as select v12 from aggJoin5457616418441773884 join aggView3790912183496765036 using(v1);
create or replace view aggView792894626720902767 as select v12 from aggJoin3418856432240719651 group by v12;
create or replace view aggJoin205947072118705095 as select title as v13 from title as t, aggView792894626720902767 where t.id=aggView792894626720902767.v12 and production_year>1990;
create or replace view res as select MIN(v13) as v24 from aggJoin205947072118705095;
select sum(v24) from res;