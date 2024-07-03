create or replace view aggView7779539209935174904 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin2206786286710813615 as select movie_id as v12 from movie_companies as mc, aggView7779539209935174904 where mc.company_id=aggView7779539209935174904.v1;
create or replace view aggView3571662190977376455 as select id as v12, title as v31 from title as t;
create or replace view aggJoin674943186145420691 as select v12, v31 from aggJoin2206786286710813615 join aggView3571662190977376455 using(v12);
create or replace view aggView1678079692431679947 as select v12, MIN(v31) as v31 from aggJoin674943186145420691 group by v12,v31;
create or replace view aggJoin3000590517753365247 as select keyword_id as v18, v31 from movie_keyword as mk, aggView1678079692431679947 where mk.movie_id=aggView1678079692431679947.v12;
create or replace view aggView1649592287370826166 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8095282193115384760 as select v31 from aggJoin3000590517753365247 join aggView1649592287370826166 using(v18);
select MIN(v31) as v31 from aggJoin8095282193115384760;
