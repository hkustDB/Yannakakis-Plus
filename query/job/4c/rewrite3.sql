create or replace view aggView2979324148594894421 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin8398158878961315830 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView2979324148594894421 where mi_idx.movie_id=aggView2979324148594894421.v14 and info>'2.0';
create or replace view aggView7260193035567497916 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5332544483183630523 as select movie_id as v14 from movie_keyword as mk, aggView7260193035567497916 where mk.keyword_id=aggView7260193035567497916.v3;
create or replace view aggView2531161514399552900 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin7514913580092736584 as select v14, v9, v27 from aggJoin8398158878961315830 join aggView2531161514399552900 using(v1);
create or replace view aggView9095841653388708372 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin7514913580092736584 group by v14;
create or replace view aggJoin2067404677884401052 as select v27, v26 from aggJoin5332544483183630523 join aggView9095841653388708372 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin2067404677884401052;
