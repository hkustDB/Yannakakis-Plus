create or replace view aggView4503692242511150557 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin7820205874901833131 as select movie_id as v15 from movie_info_idx as mi_idx, aggView4503692242511150557 where mi_idx.info_type_id=aggView4503692242511150557.v3;
create or replace view aggView7704738705878732352 as select v15 from aggJoin7820205874901833131 group by v15;
create or replace view aggJoin1203141141812656231 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView7704738705878732352 where mc.movie_id=aggView7704738705878732352.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView2642782362666343701 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5340066632888474820 as select v15, v9 from aggJoin1203141141812656231 join aggView2642782362666343701 using(v1);
create or replace view aggView5619183332742950405 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin4243309452665093874 as select v9, v28, v29 from aggJoin5340066632888474820 join aggView5619183332742950405 using(v15);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4243309452665093874;
