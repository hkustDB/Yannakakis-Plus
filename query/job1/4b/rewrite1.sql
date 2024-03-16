create or replace view aggView6766464351046761231 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5979389499914584805 as select movie_id as v14 from movie_keyword as mk, aggView6766464351046761231 where mk.keyword_id=aggView6766464351046761231.v3;
create or replace view aggView8138514914121708823 as select v14 from aggJoin5979389499914584805 group by v14;
create or replace view aggJoin8540190075450817236 as select id as v14, title as v15 from title as t, aggView8138514914121708823 where t.id=aggView8138514914121708823.v14 and production_year>2010;
create or replace view aggView5654477240377511295 as select v14, MIN(v15) as v27 from aggJoin8540190075450817236 group by v14;
create or replace view aggJoin7720918104560131720 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView5654477240377511295 where mi_idx.movie_id=aggView5654477240377511295.v14 and info>'9.0';
create or replace view aggView7889028678400982834 as select v1, MIN(v27) as v27, MIN(v9) as v26 from aggJoin7720918104560131720 group by v1;
create or replace view aggJoin8486622471873665254 as select v27, v26 from info_type as it, aggView7889028678400982834 where it.id=aggView7889028678400982834.v1 and info= 'rating';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8486622471873665254;
