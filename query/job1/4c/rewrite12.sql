create or replace view aggView2157984225628874470 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin4201162315036588846 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView2157984225628874470 where mk.movie_id=aggView2157984225628874470.v14;
create or replace view aggView3473340277675234154 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin4940938543756711381 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView3473340277675234154 where mi_idx.info_type_id=aggView3473340277675234154.v1 and info>'2.0';
create or replace view aggView8264020341446920416 as select v14, MIN(v9) as v26 from aggJoin4940938543756711381 group by v14;
create or replace view aggJoin8526939342716314672 as select v3, v27 as v27, v26 from aggJoin4201162315036588846 join aggView8264020341446920416 using(v14);
create or replace view aggView4454068350684930309 as select v3, MIN(v27) as v27, MIN(v26) as v26 from aggJoin8526939342716314672 group by v3;
create or replace view aggJoin798315720657754806 as select v27, v26 from keyword as k, aggView4454068350684930309 where k.id=aggView4454068350684930309.v3 and keyword LIKE '%sequel%';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin798315720657754806;
