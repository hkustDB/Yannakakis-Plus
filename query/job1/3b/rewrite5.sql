create or replace view aggView5366784521917327511 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin2508966762641392373 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView5366784521917327511 where mk.movie_id=aggView5366784521917327511.v12;
create or replace view aggView6147301575223633505 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin5550975631470247953 as select v1, v24 as v24 from aggJoin2508966762641392373 join aggView6147301575223633505 using(v12);
create or replace view aggView1658139867321706356 as select v1, MIN(v24) as v24 from aggJoin5550975631470247953 group by v1;
create or replace view aggJoin6900929691221711793 as select keyword as v2, v24 from keyword as k, aggView1658139867321706356 where k.id=aggView1658139867321706356.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin6900929691221711793;
select sum(v24) from res;