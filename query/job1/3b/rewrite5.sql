create or replace view aggView1196256506755087360 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin3108342444909368293 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView1196256506755087360 where mk.movie_id=aggView1196256506755087360.v12;
create or replace view aggView4667754169082555551 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin277972257526589367 as select v1, v24 as v24 from aggJoin3108342444909368293 join aggView4667754169082555551 using(v12);
create or replace view aggView6130963098585657105 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4947739553393276176 as select v24 from aggJoin277972257526589367 join aggView6130963098585657105 using(v1);
select MIN(v24) as v24 from aggJoin4947739553393276176;
