create or replace view aggView7385211994593418103 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7113625367086462051 as select movie_id as v12 from movie_keyword as mk, aggView7385211994593418103 where mk.keyword_id=aggView7385211994593418103.v18;
create or replace view aggView6797200789853714656 as select v12 from aggJoin7113625367086462051 group by v12;
create or replace view aggJoin8176353433613366255 as select movie_id as v12, company_id as v1 from movie_companies as mc, aggView6797200789853714656 where mc.movie_id=aggView6797200789853714656.v12;
create or replace view aggView2492975511896750909 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin1790291587742559015 as select v12 from aggJoin8176353433613366255 join aggView2492975511896750909 using(v1);
create or replace view aggView5561019642051980353 as select v12 from aggJoin1790291587742559015 group by v12;
create or replace view aggJoin1316043959769047198 as select title as v20 from title as t, aggView5561019642051980353 where t.id=aggView5561019642051980353.v12;
select MIN(v20) as v31 from aggJoin1316043959769047198;
