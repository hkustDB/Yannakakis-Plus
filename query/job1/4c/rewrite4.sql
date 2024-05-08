create or replace view aggView3555693647175070836 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5572697144548573340 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView3555693647175070836 where mi_idx.info_type_id=aggView3555693647175070836.v1 and info>'2.0';
create or replace view aggView8766999258615633622 as select v14, MIN(v9) as v26 from aggJoin5572697144548573340 group by v14;
create or replace view aggJoin3409708759624367695 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView8766999258615633622 where t.id=aggView8766999258615633622.v14 and production_year>1990;
create or replace view aggView8464362553573815936 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin3409708759624367695 group by v14;
create or replace view aggJoin4982814365525828308 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView8464362553573815936 where mk.movie_id=aggView8464362553573815936.v14;
create or replace view aggView5681946806751432842 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6938816191585570186 as select v26, v27 from aggJoin4982814365525828308 join aggView5681946806751432842 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin6938816191585570186;
