create or replace view aggView9156864025232773877 as select id as v12, title as v31 from title as t;
create or replace view aggJoin5231363305526123536 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView9156864025232773877 where mk.movie_id=aggView9156864025232773877.v12;
create or replace view aggView3456195331974199117 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7083077959145799869 as select v12, v31 from aggJoin5231363305526123536 join aggView3456195331974199117 using(v18);
create or replace view aggView4724208390511849597 as select v12, MIN(v31) as v31 from aggJoin7083077959145799869 group by v12;
create or replace view aggJoin1000913162459651534 as select company_id as v1, v31 from movie_companies as mc, aggView4724208390511849597 where mc.movie_id=aggView4724208390511849597.v12;
create or replace view aggView3196014833574978054 as select v1, MIN(v31) as v31 from aggJoin1000913162459651534 group by v1;
create or replace view aggJoin4922870758924395317 as select country_code as v3, v31 from company_name as cn, aggView3196014833574978054 where cn.id=aggView3196014833574978054.v1 and country_code= '[de]';
select MIN(v31) as v31 from aggJoin4922870758924395317;
