create or replace view aggView6487747474108509774 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin6916389011420250469 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView6487747474108509774 where mk.movie_id=aggView6487747474108509774.v14;
create or replace view aggView3117559532959865838 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin545567417334153610 as select v14, v27 from aggJoin6916389011420250469 join aggView3117559532959865838 using(v3);
create or replace view aggView4040053326903529615 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin2306858189005957109 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView4040053326903529615 where mi_idx.info_type_id=aggView4040053326903529615.v1 and info>'9.0';
create or replace view aggView3434279908766892403 as select v14, MIN(v9) as v26 from aggJoin2306858189005957109 group by v14;
create or replace view aggJoin8318836931668652517 as select v27 as v27, v26 from aggJoin545567417334153610 join aggView3434279908766892403 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8318836931668652517;
