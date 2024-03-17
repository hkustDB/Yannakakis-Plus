create or replace view aggView4804802096376627901 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin7271541325575391733 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView4804802096376627901 where mi_idx.info_type_id=aggView4804802096376627901.v1 and info>'5.0';
create or replace view aggView7968088855244447251 as select v14, MIN(v9) as v26 from aggJoin7271541325575391733 group by v14;
create or replace view aggJoin5601335457223486428 as select id as v14, title as v15, v26 from title as t, aggView7968088855244447251 where t.id=aggView7968088855244447251.v14 and production_year>2005;
create or replace view aggView2732185104670017015 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin5601335457223486428 group by v14;
create or replace view aggJoin1883418135755864758 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView2732185104670017015 where mk.movie_id=aggView2732185104670017015.v14;
create or replace view aggView2758648190038308828 as select v3, MIN(v26) as v26, MIN(v27) as v27 from aggJoin1883418135755864758 group by v3;
create or replace view aggJoin7640533041736430120 as select v26, v27 from keyword as k, aggView2758648190038308828 where k.id=aggView2758648190038308828.v3 and keyword LIKE '%sequel%';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin7640533041736430120;
