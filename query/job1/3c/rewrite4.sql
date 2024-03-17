create or replace view aggView2680813275364084650 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin299286053747406502 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView2680813275364084650 where mi.movie_id=aggView2680813275364084650.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView4178252682908357894 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6211648411140133492 as select movie_id as v12 from movie_keyword as mk, aggView4178252682908357894 where mk.keyword_id=aggView4178252682908357894.v1;
create or replace view aggView8894190939502447536 as select v12 from aggJoin6211648411140133492 group by v12;
create or replace view aggJoin3877780271983272546 as select v7, v24 as v24 from aggJoin299286053747406502 join aggView8894190939502447536 using(v12);
create or replace view res as select MIN(v24) as v24 from aggJoin3877780271983272546;
select sum(v24) from res;