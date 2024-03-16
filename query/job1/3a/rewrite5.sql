create or replace view aggView9177527056017347256 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin2306037951763295432 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView9177527056017347256 where mi.movie_id=aggView9177527056017347256.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView819551443443784895 as select v12, MIN(v24) as v24 from aggJoin2306037951763295432 group by v12;
create or replace view aggJoin7613605531537563978 as select keyword_id as v1, v24 from movie_keyword as mk, aggView819551443443784895 where mk.movie_id=aggView819551443443784895.v12;
create or replace view aggView6940561382984462017 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7517560490205533557 as select v24 from aggJoin7613605531537563978 join aggView6940561382984462017 using(v1);
select MIN(v24) as v24 from aggJoin7517560490205533557;
