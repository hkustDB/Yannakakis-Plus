create or replace view aggView6858742754505041527 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin4675535801599477062 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView6858742754505041527 where mi.movie_id=aggView6858742754505041527.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView2649921873390290477 as select v12, MIN(v24) as v24 from aggJoin4675535801599477062 group by v12;
create or replace view aggJoin173753960156236487 as select keyword_id as v1, v24 from movie_keyword as mk, aggView2649921873390290477 where mk.movie_id=aggView2649921873390290477.v12;
create or replace view aggView6489294015016952810 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2226223354910674194 as select v24 from aggJoin173753960156236487 join aggView6489294015016952810 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin2226223354910674194;
select sum(v24) from res;