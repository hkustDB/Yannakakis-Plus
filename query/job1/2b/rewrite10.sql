create or replace view aggView2656697266524083395 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1402133381836987383 as select movie_id as v12 from movie_keyword as mk, aggView2656697266524083395 where mk.keyword_id=aggView2656697266524083395.v18;
create or replace view aggView4121601185472316204 as select v12 from aggJoin1402133381836987383 group by v12;
create or replace view aggJoin6968889227872444629 as select id as v12, title as v20 from title as t, aggView4121601185472316204 where t.id=aggView4121601185472316204.v12;
create or replace view aggView7959634061399443349 as select v12, MIN(v20) as v31 from aggJoin6968889227872444629 group by v12;
create or replace view aggJoin178698959580709696 as select company_id as v1, v31 from movie_companies as mc, aggView7959634061399443349 where mc.movie_id=aggView7959634061399443349.v12;
create or replace view aggView673469096843179848 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin82855753580109525 as select v31 from aggJoin178698959580709696 join aggView673469096843179848 using(v1);
select MIN(v31) as v31 from aggJoin82855753580109525;
