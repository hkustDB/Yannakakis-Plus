create or replace view aggView3693135913417638813 as select id as v12, title as v31 from title as t;
create or replace view aggJoin6938043866346424923 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView3693135913417638813 where mc.movie_id=aggView3693135913417638813.v12;
create or replace view aggView3798558937180205707 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5581835709589729086 as select movie_id as v12 from movie_keyword as mk, aggView3798558937180205707 where mk.keyword_id=aggView3798558937180205707.v18;
create or replace view aggView4430614118411101755 as select v12 from aggJoin5581835709589729086 group by v12;
create or replace view aggJoin4390815146055292086 as select v1, v31 as v31 from aggJoin6938043866346424923 join aggView4430614118411101755 using(v12);
create or replace view aggView3909817920710708117 as select v1, MIN(v31) as v31 from aggJoin4390815146055292086 group by v1;
create or replace view aggJoin2973530189413466434 as select country_code as v3, v31 from company_name as cn, aggView3909817920710708117 where cn.id=aggView3909817920710708117.v1 and country_code= '[sm]';
select MIN(v31) as v31 from aggJoin2973530189413466434;
