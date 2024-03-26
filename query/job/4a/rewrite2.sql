create or replace view aggView9083005549315147716 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin1951984913908545962 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView9083005549315147716 where mi_idx.movie_id=aggView9083005549315147716.v14 and info>'5.0';
create or replace view aggView6474286859587177286 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1401217297556952720 as select v14, v9, v27 from aggJoin1951984913908545962 join aggView6474286859587177286 using(v1);
create or replace view aggView7605036062320849102 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin1401217297556952720 group by v14;
create or replace view aggJoin6890179760449187523 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView7605036062320849102 where mk.movie_id=aggView7605036062320849102.v14;
create or replace view aggView6593918493120472383 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5781196517459299643 as select v27, v26 from aggJoin6890179760449187523 join aggView6593918493120472383 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin5781196517459299643;
