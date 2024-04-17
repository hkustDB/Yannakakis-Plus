create or replace view aggView7801395876695594835 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin808828185610473926 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView7801395876695594835 where mi_idx.movie_id=aggView7801395876695594835.v14 and info>'9.0';
create or replace view aggView5197485563852105388 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin2720818616116400502 as select v14, v9, v27 from aggJoin808828185610473926 join aggView5197485563852105388 using(v1);
create or replace view aggView8272591817337237033 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin2720818616116400502 group by v14,v27;
create or replace view aggJoin910476634929007384 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView8272591817337237033 where mk.movie_id=aggView8272591817337237033.v14;
create or replace view aggView7719162802563464315 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2241488409320581809 as select v27, v26 from aggJoin910476634929007384 join aggView7719162802563464315 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin2241488409320581809;
