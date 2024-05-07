create or replace view aggView8548393663213718858 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin76964329858355228 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView8548393663213718858 where mi_idx.info_type_id=aggView8548393663213718858.v1 and info>'2.0';
create or replace view aggView4621297562002706710 as select v14, MIN(v9) as v26 from aggJoin76964329858355228 group by v14;
create or replace view aggJoin2673692288442859614 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView4621297562002706710 where t.id=aggView4621297562002706710.v14 and production_year>1990;
create or replace view aggView6762128169058535124 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin2673692288442859614 group by v14;
create or replace view aggJoin6029770620233528017 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView6762128169058535124 where mk.movie_id=aggView6762128169058535124.v14;
create or replace view aggView7593388461776041401 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2247636866214615630 as select v26, v27 from aggJoin6029770620233528017 join aggView7593388461776041401 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin2247636866214615630;
