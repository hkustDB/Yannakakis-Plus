create or replace view aggView8546991863302424210 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin593185407011987481 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView8546991863302424210 where mk.movie_id=aggView8546991863302424210.v12;
create or replace view aggView9179066112146989831 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin476858497365909634 as select v1, v24 as v24 from aggJoin593185407011987481 join aggView9179066112146989831 using(v12);
create or replace view aggView3400107228584343717 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6087861162291264292 as select v24 from aggJoin476858497365909634 join aggView3400107228584343717 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin6087861162291264292;
select sum(v24) from res;