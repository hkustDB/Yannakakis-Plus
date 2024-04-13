create or replace view aggView6490955966055765218 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin6653290228770944766 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView6490955966055765218 where mk.movie_id=aggView6490955966055765218.v14;
create or replace view aggView3638474841241311965 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5803600089561732972 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView3638474841241311965 where mi_idx.info_type_id=aggView3638474841241311965.v1 and info>'5.0';
create or replace view aggView8010405788104214025 as select v14, MIN(v9) as v26 from aggJoin5803600089561732972 group by v14;
create or replace view aggJoin3218983345887085613 as select v3, v27 as v27, v26 from aggJoin6653290228770944766 join aggView8010405788104214025 using(v14);
create or replace view aggView2024556472818836822 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin9068731356880329496 as select v27, v26 from aggJoin3218983345887085613 join aggView2024556472818836822 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin9068731356880329496;
