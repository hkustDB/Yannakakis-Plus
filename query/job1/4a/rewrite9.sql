create or replace view aggView763732188706554656 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin2711643590210400328 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView763732188706554656 where mi_idx.info_type_id=aggView763732188706554656.v1 and info>'5.0';
create or replace view aggView5431855945424324523 as select v14, MIN(v9) as v26 from aggJoin2711643590210400328 group by v14;
create or replace view aggJoin3207478047376409211 as select id as v14, title as v15, v26 from title as t, aggView5431855945424324523 where t.id=aggView5431855945424324523.v14 and production_year>2005;
create or replace view aggView8693031918910571897 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin3207478047376409211 group by v14;
create or replace view aggJoin4793756556215891480 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView8693031918910571897 where mk.movie_id=aggView8693031918910571897.v14;
create or replace view aggView7482027440456590756 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3035715238505965999 as select v26, v27 from aggJoin4793756556215891480 join aggView7482027440456590756 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin3035715238505965999;
