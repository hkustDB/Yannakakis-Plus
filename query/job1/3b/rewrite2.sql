create or replace view aggView4130748072256455182 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin7392839245950699308 as select id as v12, title as v13 from title as t, aggView4130748072256455182 where t.id=aggView4130748072256455182.v12 and production_year>2010;
create or replace view aggView9055493150105081531 as select v12, MIN(v13) as v24 from aggJoin7392839245950699308 group by v12;
create or replace view aggJoin7074202736608180374 as select keyword_id as v1, v24 from movie_keyword as mk, aggView9055493150105081531 where mk.movie_id=aggView9055493150105081531.v12;
create or replace view aggView2324683676549412471 as select v1, MIN(v24) as v24 from aggJoin7074202736608180374 group by v1;
create or replace view aggJoin1680925085157807984 as select v24 from keyword as k, aggView2324683676549412471 where k.id=aggView2324683676549412471.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin1680925085157807984;
select sum(v24) from res;