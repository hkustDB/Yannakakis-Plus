create or replace view aggView8542503524877229477 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin2073018370288474818 as select id as v12, title as v13, production_year as v16 from title as t, aggView8542503524877229477 where t.id=aggView8542503524877229477.v12 and production_year>2005;
create or replace view aggView6596964121595516127 as select v12, MIN(v13) as v24 from aggJoin2073018370288474818 group by v12;
create or replace view aggJoin5168656884296840475 as select keyword_id as v1, v24 from movie_keyword as mk, aggView6596964121595516127 where mk.movie_id=aggView6596964121595516127.v12;
create or replace view aggView975237340276526603 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2393761685388106760 as select v24 from aggJoin5168656884296840475 join aggView975237340276526603 using(v1);
select MIN(v24) as v24 from aggJoin2393761685388106760;
