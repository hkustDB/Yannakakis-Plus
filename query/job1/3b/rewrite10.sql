create or replace view aggView6520631620909201292 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin47368382691980971 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView6520631620909201292 where mk.movie_id=aggView6520631620909201292.v12;
create or replace view aggView5577479343647608842 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin182903599835103541 as select v12 from aggJoin47368382691980971 join aggView5577479343647608842 using(v1);
create or replace view aggView8837068937452182428 as select v12 from aggJoin182903599835103541 group by v12;
create or replace view aggJoin7937494691279854338 as select title as v13 from title as t, aggView8837068937452182428 where t.id=aggView8837068937452182428.v12 and production_year>2010;
create or replace view res as select MIN(v13) as v24 from aggJoin7937494691279854338;
select sum(v24) from res;