create or replace view aggView5247123858988804251 as select id as v12, title as v31 from title as t;
create or replace view aggJoin7910529963397172741 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView5247123858988804251 where mk.movie_id=aggView5247123858988804251.v12;
create or replace view aggView7868417425539268692 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin6293918682392541075 as select movie_id as v12 from movie_companies as mc, aggView7868417425539268692 where mc.company_id=aggView7868417425539268692.v1;
create or replace view aggView4463624051371098606 as select v12 from aggJoin6293918682392541075 group by v12;
create or replace view aggJoin6051043355399310599 as select v18, v31 as v31 from aggJoin7910529963397172741 join aggView4463624051371098606 using(v12);
create or replace view aggView155272295855543641 as select v18, MIN(v31) as v31 from aggJoin6051043355399310599 group by v18;
create or replace view aggJoin3998903408537341281 as select keyword as v9, v31 from keyword as k, aggView155272295855543641 where k.id=aggView155272295855543641.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin3998903408537341281;
