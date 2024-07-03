create or replace view aggView3965637301900925128 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin3978570411428703927 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView3965637301900925128 where mi_idx.info_type_id=aggView3965637301900925128.v1 and info>'9.0';
create or replace view aggView3626643259206046476 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin2406001450342470066 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView3626643259206046476 where mk.movie_id=aggView3626643259206046476.v14;
create or replace view aggView2138177976214373484 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6660537062028688977 as select v14, v27 from aggJoin2406001450342470066 join aggView2138177976214373484 using(v3);
create or replace view aggView251383993055031894 as select v14, MIN(v9) as v26 from aggJoin3978570411428703927 group by v14;
create or replace view aggJoin7632123652360500455 as select v27 as v27, v26 from aggJoin6660537062028688977 join aggView251383993055031894 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin7632123652360500455;
