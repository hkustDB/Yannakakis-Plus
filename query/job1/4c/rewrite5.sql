create or replace view aggView3255430998323083071 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin6610196475288012454 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView3255430998323083071 where mi_idx.info_type_id=aggView3255430998323083071.v1 and info>'2.0';
create or replace view aggView7361557180539979687 as select v14, MIN(v9) as v26 from aggJoin6610196475288012454 group by v14;
create or replace view aggJoin1819749896153153600 as select movie_id as v14, keyword_id as v3, v26 from movie_keyword as mk, aggView7361557180539979687 where mk.movie_id=aggView7361557180539979687.v14;
create or replace view aggView6784401064925001684 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8511537083854053232 as select v14, v26 from aggJoin1819749896153153600 join aggView6784401064925001684 using(v3);
create or replace view aggView2754056714580570309 as select v14, MIN(v26) as v26 from aggJoin8511537083854053232 group by v14;
create or replace view aggJoin1492208090624085069 as select title as v15, v26 from title as t, aggView2754056714580570309 where t.id=aggView2754056714580570309.v14 and production_year>1990;
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin1492208090624085069;
