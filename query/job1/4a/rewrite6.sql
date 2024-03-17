create or replace view aggView653664565949286849 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1084636294438179746 as select movie_id as v14 from movie_keyword as mk, aggView653664565949286849 where mk.keyword_id=aggView653664565949286849.v3;
create or replace view aggView2617700460403091354 as select v14 from aggJoin1084636294438179746 group by v14;
create or replace view aggJoin6273170936561556557 as select id as v14, title as v15 from title as t, aggView2617700460403091354 where t.id=aggView2617700460403091354.v14 and production_year>2005;
create or replace view aggView3361855120573529004 as select v14, MIN(v15) as v27 from aggJoin6273170936561556557 group by v14;
create or replace view aggJoin2601205461868438923 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView3361855120573529004 where mi_idx.movie_id=aggView3361855120573529004.v14 and info>'5.0';
create or replace view aggView5864036918119103796 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin3148291321629659289 as select v9, v27 from aggJoin2601205461868438923 join aggView5864036918119103796 using(v1);
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin3148291321629659289;
