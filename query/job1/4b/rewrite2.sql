create or replace view aggView4444006213225674558 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin8921541988327627314 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView4444006213225674558 where mi_idx.movie_id=aggView4444006213225674558.v14 and info>'9.0';
create or replace view aggView933434136929523973 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin3344431687616875775 as select v14, v9, v27 from aggJoin8921541988327627314 join aggView933434136929523973 using(v1);
create or replace view aggView2856106378542804539 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin3344431687616875775 group by v14;
create or replace view aggJoin5098867440254186516 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView2856106378542804539 where mk.movie_id=aggView2856106378542804539.v14;
create or replace view aggView7261649399008071621 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3275271950320959356 as select v27, v26 from aggJoin5098867440254186516 join aggView7261649399008071621 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin3275271950320959356;
