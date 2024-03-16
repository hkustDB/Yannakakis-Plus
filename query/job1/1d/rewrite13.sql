create or replace view aggView6753761990272479326 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin9030714296285233272 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView6753761990272479326 where mi_idx.movie_id=aggView6753761990272479326.v15;
create or replace view aggView7175697907895841655 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin902273897481957388 as select v15, v28, v29 from aggJoin9030714296285233272 join aggView7175697907895841655 using(v3);
create or replace view aggView3268161433604563049 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4684428835139884944 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3268161433604563049 where mc.company_type_id=aggView3268161433604563049.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView651882682990251282 as select v15, MIN(v9) as v27 from aggJoin4684428835139884944 group by v15;
create or replace view aggJoin8234690211833786630 as select v28 as v28, v29 as v29, v27 from aggJoin902273897481957388 join aggView651882682990251282 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin8234690211833786630;
