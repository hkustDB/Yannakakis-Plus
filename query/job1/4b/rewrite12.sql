create or replace view aggView3298249325863167275 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin4665152510499289069 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView3298249325863167275 where mi_idx.movie_id=aggView3298249325863167275.v14 and info>'9.0';
create or replace view aggView2404621644651950543 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin2767084417239488580 as select v14, v9, v27 from aggJoin4665152510499289069 join aggView2404621644651950543 using(v1);
create or replace view aggView2116566504690267714 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin2767084417239488580 group by v14;
create or replace view aggJoin7622448385585977336 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView2116566504690267714 where mk.movie_id=aggView2116566504690267714.v14;
create or replace view aggView2337470388241675634 as select v3, MIN(v27) as v27, MIN(v26) as v26 from aggJoin7622448385585977336 group by v3;
create or replace view aggJoin401124958187548521 as select v27, v26 from keyword as k, aggView2337470388241675634 where k.id=aggView2337470388241675634.v3 and keyword LIKE '%sequel%';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin401124958187548521;
