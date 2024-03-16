create or replace view aggView2353214146733998497 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin6314670670325082526 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView2353214146733998497 where mi_idx.movie_id=aggView2353214146733998497.v14 and info>'2.0';
create or replace view aggView7159961306465243156 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2743224279931897576 as select movie_id as v14 from movie_keyword as mk, aggView7159961306465243156 where mk.keyword_id=aggView7159961306465243156.v3;
create or replace view aggView191731568728654703 as select v14 from aggJoin2743224279931897576 group by v14;
create or replace view aggJoin1395264592820782063 as select v1, v9, v27 as v27 from aggJoin6314670670325082526 join aggView191731568728654703 using(v14);
create or replace view aggView8844520336652793372 as select v1, MIN(v27) as v27, MIN(v9) as v26 from aggJoin1395264592820782063 group by v1;
create or replace view aggJoin1206866605264526419 as select v27, v26 from info_type as it, aggView8844520336652793372 where it.id=aggView8844520336652793372.v1 and info= 'rating';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin1206866605264526419;
