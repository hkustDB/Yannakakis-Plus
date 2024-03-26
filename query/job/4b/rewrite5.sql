create or replace view aggView8790810754443743592 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin245777396591915152 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView8790810754443743592 where mk.movie_id=aggView8790810754443743592.v14;
create or replace view aggView5301582239287317940 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8097557408152660407 as select v14, v27 from aggJoin245777396591915152 join aggView5301582239287317940 using(v3);
create or replace view aggView6333233795713656309 as select v14, MIN(v27) as v27 from aggJoin8097557408152660407 group by v14;
create or replace view aggJoin3499527208459398441 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView6333233795713656309 where mi_idx.movie_id=aggView6333233795713656309.v14 and info>'9.0';
create or replace view aggView8750511964465936629 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin4713172470477643285 as select v9, v27 from aggJoin3499527208459398441 join aggView8750511964465936629 using(v1);
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin4713172470477643285;
