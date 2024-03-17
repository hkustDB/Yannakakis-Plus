create or replace view aggView3142632584595922829 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin5819879025695469478 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView3142632584595922829 where mi_idx.movie_id=aggView3142632584595922829.v14 and info>'2.0';
create or replace view aggView5970194754231773572 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin4802520553802727514 as select v14, v9, v27 from aggJoin5819879025695469478 join aggView5970194754231773572 using(v1);
create or replace view aggView4320045489416547994 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin4802520553802727514 group by v14;
create or replace view aggJoin2744835127192180511 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView4320045489416547994 where mk.movie_id=aggView4320045489416547994.v14;
create or replace view aggView184127337414443638 as select v3, MIN(v27) as v27, MIN(v26) as v26 from aggJoin2744835127192180511 group by v3;
create or replace view aggJoin910818571006073707 as select v27, v26 from keyword as k, aggView184127337414443638 where k.id=aggView184127337414443638.v3 and keyword LIKE '%sequel%';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin910818571006073707;
