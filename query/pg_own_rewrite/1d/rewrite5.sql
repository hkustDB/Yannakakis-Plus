create or replace view aggView6438113716452612677 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin2030734569097648603 as select movie_id as v15 from movie_info_idx as mi_idx, aggView6438113716452612677 where mi_idx.info_type_id=aggView6438113716452612677.v3;
create or replace view aggView3738310864000751192 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8488188344684444606 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3738310864000751192 where mc.company_type_id=aggView3738310864000751192.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView4647064656876995311 as select v15 from aggJoin2030734569097648603 group by v15;
create or replace view aggJoin8926426715038927895 as select id as v15, title as v16, production_year as v19 from title as t, aggView4647064656876995311 where t.id=aggView4647064656876995311.v15 and production_year>2000;
create or replace view aggView6739083238692675727 as select v15, MIN(v9) as v27 from aggJoin8488188344684444606 group by v15;
create or replace view aggJoin601345444087423848 as select v16, v19, v27 from aggJoin8926426715038927895 join aggView6739083238692675727 using(v15);
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin601345444087423848;
