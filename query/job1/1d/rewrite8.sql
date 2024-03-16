create or replace view aggView8233626046391805973 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin6833092462399556817 as select movie_id as v15 from movie_info_idx as mi_idx, aggView8233626046391805973 where mi_idx.info_type_id=aggView8233626046391805973.v3;
create or replace view aggView3776269187277985320 as select v15 from aggJoin6833092462399556817 group by v15;
create or replace view aggJoin7754422776710918402 as select id as v15, title as v16, production_year as v19 from title as t, aggView3776269187277985320 where t.id=aggView3776269187277985320.v15 and production_year>2000;
create or replace view aggView3854377704150058634 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin7754422776710918402 group by v15;
create or replace view aggJoin3805293711843391963 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView3854377704150058634 where mc.movie_id=aggView3854377704150058634.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView2209431893463755906 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8119611020062387783 as select v9, v28, v29 from aggJoin3805293711843391963 join aggView2209431893463755906 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin8119611020062387783;
