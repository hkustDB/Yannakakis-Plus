create or replace view aggView6831383738592998098 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin5174875120530356327 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView6831383738592998098 where mk.movie_id=aggView6831383738592998098.v14;
create or replace view aggView1606569027486232859 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin3189233179280623302 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView1606569027486232859 where mi_idx.info_type_id=aggView1606569027486232859.v1 and info>'5.0';
create or replace view aggView5686780165692914277 as select v14, MIN(v9) as v26 from aggJoin3189233179280623302 group by v14;
create or replace view aggJoin5846447005430283449 as select v3, v27 as v27, v26 from aggJoin5174875120530356327 join aggView5686780165692914277 using(v14);
create or replace view aggView6906353925636917912 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3042941346578557322 as select v27, v26 from aggJoin5846447005430283449 join aggView6906353925636917912 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin3042941346578557322;
