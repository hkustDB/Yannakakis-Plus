create or replace view aggView1882379181580779149 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin5784192069072419493 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView1882379181580779149 where mk.movie_id=aggView1882379181580779149.v14;
create or replace view aggView7552078780297200897 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5324972628097831121 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView7552078780297200897 where mi_idx.info_type_id=aggView7552078780297200897.v1 and info>'9.0';
create or replace view aggView5319931189082905999 as select v14, MIN(v9) as v26 from aggJoin5324972628097831121 group by v14;
create or replace view aggJoin4217759559219935386 as select v3, v27 as v27, v26 from aggJoin5784192069072419493 join aggView5319931189082905999 using(v14);
create or replace view aggView1799817595239348103 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6330500128101164496 as select v27, v26 from aggJoin4217759559219935386 join aggView1799817595239348103 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin6330500128101164496;
