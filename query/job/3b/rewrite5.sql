create or replace view aggView3749776253664565845 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin2214106803467113790 as select id as v12, title as v13 from title as t, aggView3749776253664565845 where t.id=aggView3749776253664565845.v12 and production_year>2010;
create or replace view aggView4625447801431101885 as select v12, MIN(v13) as v24 from aggJoin2214106803467113790 group by v12;
create or replace view aggJoin5238108129144410606 as select keyword_id as v1, v24 from movie_keyword as mk, aggView4625447801431101885 where mk.movie_id=aggView4625447801431101885.v12;
create or replace view aggView1266970977562934808 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8476882514157090120 as select v24 from aggJoin5238108129144410606 join aggView1266970977562934808 using(v1);
select MIN(v24) as v24 from aggJoin8476882514157090120;
