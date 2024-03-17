create or replace view aggView158249340349995150 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin2339382923144698549 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView158249340349995150 where mk.movie_id=aggView158249340349995150.v14;
create or replace view aggView3770414073965110621 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1400595653225142789 as select v14, v27 from aggJoin2339382923144698549 join aggView3770414073965110621 using(v3);
create or replace view aggView8332175593278796024 as select v14, MIN(v27) as v27 from aggJoin1400595653225142789 group by v14;
create or replace view aggJoin4985653866576376766 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView8332175593278796024 where mi_idx.movie_id=aggView8332175593278796024.v14 and info>'5.0';
create or replace view aggView4846328477184891894 as select v1, MIN(v27) as v27, MIN(v9) as v26 from aggJoin4985653866576376766 group by v1;
create or replace view aggJoin2571529423070311573 as select v27, v26 from info_type as it, aggView4846328477184891894 where it.id=aggView4846328477184891894.v1 and info= 'rating';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin2571529423070311573;
