create or replace view aggView8889800119442179334 as select id as v12, title as v31 from title as t;
create or replace view aggJoin2528329217599851774 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView8889800119442179334 where mk.movie_id=aggView8889800119442179334.v12;
create or replace view aggView7128893395631407185 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin8614765179125417394 as select movie_id as v12 from movie_companies as mc, aggView7128893395631407185 where mc.company_id=aggView7128893395631407185.v1;
create or replace view aggView8460638119344675064 as select v12 from aggJoin8614765179125417394 group by v12;
create or replace view aggJoin813072483105699518 as select v18, v31 as v31 from aggJoin2528329217599851774 join aggView8460638119344675064 using(v12);
create or replace view aggView3230179553926990454 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8500810719634928107 as select v31 from aggJoin813072483105699518 join aggView3230179553926990454 using(v18);
select MIN(v31) as v31 from aggJoin8500810719634928107;
