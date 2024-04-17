create or replace view aggView7344906305784408886 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin4217258273892317906 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView7344906305784408886 where mi_idx.info_type_id=aggView7344906305784408886.v1 and info>'9.0';
create or replace view aggView932057218852625849 as select v14, MIN(v9) as v26 from aggJoin4217258273892317906 group by v14;
create or replace view aggJoin5368827245716424219 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView932057218852625849 where t.id=aggView932057218852625849.v14 and production_year>2010;
create or replace view aggView164746457435619581 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin5368827245716424219 group by v14,v26;
create or replace view aggJoin8790262767798971826 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView164746457435619581 where mk.movie_id=aggView164746457435619581.v14;
create or replace view aggView1435835124772214419 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3844310927406412829 as select v26, v27 from aggJoin8790262767798971826 join aggView1435835124772214419 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin3844310927406412829;
