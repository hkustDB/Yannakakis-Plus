create or replace view aggView8728322846714639243 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin7026236427072156332 as select movie_id as v12 from movie_companies as mc, aggView8728322846714639243 where mc.company_id=aggView8728322846714639243.v1;
create or replace view aggView6026815656045956066 as select v12 from aggJoin7026236427072156332 group by v12;
create or replace view aggJoin1358603901469168436 as select movie_id as v12, keyword_id as v18 from movie_keyword as mk, aggView6026815656045956066 where mk.movie_id=aggView6026815656045956066.v12;
create or replace view aggView4020971503383315511 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1715967203590421974 as select v12 from aggJoin1358603901469168436 join aggView4020971503383315511 using(v18);
create or replace view aggView6166998732779273924 as select id as v12, title as v31 from title as t;
create or replace view aggJoin8001364876193246515 as select v31 from aggJoin1715967203590421974 join aggView6166998732779273924 using(v12);
select MIN(v31) as v31 from aggJoin8001364876193246515;
