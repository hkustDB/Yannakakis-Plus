create or replace view aggView1136481142228762987 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin7627724429296438377 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView1136481142228762987 where mk.movie_id=aggView1136481142228762987.v14;
create or replace view aggView436074596627766512 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5129663413958524866 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView436074596627766512 where mi_idx.info_type_id=aggView436074596627766512.v1 and info>'5.0';
create or replace view aggView2726203134150924895 as select v14, MIN(v9) as v26 from aggJoin5129663413958524866 group by v14;
create or replace view aggJoin6568439072438539385 as select v3, v27 as v27, v26 from aggJoin7627724429296438377 join aggView2726203134150924895 using(v14);
create or replace view aggView2364282425806842605 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5251391740540260578 as select v27, v26 from aggJoin6568439072438539385 join aggView2364282425806842605 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin5251391740540260578;
