create or replace view aggView8082306503368388453 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin7764896952182978901 as select movie_id as v12 from movie_companies as mc, aggView8082306503368388453 where mc.company_id=aggView8082306503368388453.v1;
create or replace view aggView8120409412994412666 as select v12 from aggJoin7764896952182978901 group by v12;
create or replace view aggJoin4192562613371875679 as select id as v12, title as v20 from title as t, aggView8120409412994412666 where t.id=aggView8120409412994412666.v12;
create or replace view aggView7176905184663245323 as select v12, MIN(v20) as v31 from aggJoin4192562613371875679 group by v12;
create or replace view aggJoin132168199958398143 as select keyword_id as v18, v31 from movie_keyword as mk, aggView7176905184663245323 where mk.movie_id=aggView7176905184663245323.v12;
create or replace view aggView4564517529412128506 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1569054231649719368 as select v31 from aggJoin132168199958398143 join aggView4564517529412128506 using(v18);
select MIN(v31) as v31 from aggJoin1569054231649719368;
