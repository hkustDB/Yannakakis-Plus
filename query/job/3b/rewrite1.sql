create or replace view aggView6866047403885576506 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin94880347791908175 as select movie_id as v12 from movie_keyword as mk, aggView6866047403885576506 where mk.keyword_id=aggView6866047403885576506.v1;
create or replace view aggView7290200669574618034 as select v12 from aggJoin94880347791908175 group by v12;
create or replace view aggJoin2776054798046203246 as select id as v12, title as v13, production_year as v16 from title as t, aggView7290200669574618034 where t.id=aggView7290200669574618034.v12 and production_year>2010;
create or replace view aggView5988115836607710318 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin5629170210382976225 as select v13, v16 from aggJoin2776054798046203246 join aggView5988115836607710318 using(v12);
create or replace view aggView4709938249269834526 as select v13 from aggJoin5629170210382976225 group by v13;
select (v13) as v24 from aggView4709938249269834526;
