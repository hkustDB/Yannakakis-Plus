create or replace view aggView6477756000507334476 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin8717369323298004875 as select movie_id as v12 from movie_companies as mc, aggView6477756000507334476 where mc.company_id=aggView6477756000507334476.v1;
create or replace view aggView8896763700554282860 as select v12 from aggJoin8717369323298004875 group by v12;
create or replace view aggJoin2972669992348209655 as select movie_id as v12, keyword_id as v18 from movie_keyword as mk, aggView8896763700554282860 where mk.movie_id=aggView8896763700554282860.v12;
create or replace view aggView7184163589735053883 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7041079262918378368 as select v12 from aggJoin2972669992348209655 join aggView7184163589735053883 using(v18);
create or replace view aggView4962523175799322495 as select v12 from aggJoin7041079262918378368 group by v12;
create or replace view aggJoin7991288720095119044 as select title as v20 from title as t, aggView4962523175799322495 where t.id=aggView4962523175799322495.v12;
select MIN(v20) as v31 from aggJoin7991288720095119044;
