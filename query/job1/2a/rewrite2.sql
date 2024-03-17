create or replace view aggView2258236808101380758 as select id as v12, title as v31 from title as t;
create or replace view aggJoin6400958928443017834 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView2258236808101380758 where mc.movie_id=aggView2258236808101380758.v12;
create or replace view aggView7919390151257353840 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin5504511115904509515 as select v12, v31 from aggJoin6400958928443017834 join aggView7919390151257353840 using(v1);
create or replace view aggView1646863663057968813 as select v12, MIN(v31) as v31 from aggJoin5504511115904509515 group by v12;
create or replace view aggJoin2572431078466969980 as select keyword_id as v18, v31 from movie_keyword as mk, aggView1646863663057968813 where mk.movie_id=aggView1646863663057968813.v12;
create or replace view aggView6481049044341825916 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin400490259358044178 as select v31 from aggJoin2572431078466969980 join aggView6481049044341825916 using(v18);
select MIN(v31) as v31 from aggJoin400490259358044178;
