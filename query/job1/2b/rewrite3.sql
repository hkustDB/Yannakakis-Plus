create or replace view aggView6734652807221538270 as select id as v12, title as v31 from title as t;
create or replace view aggJoin4480434926203662049 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView6734652807221538270 where mc.movie_id=aggView6734652807221538270.v12;
create or replace view aggView5619110282312741960 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin2296871370449718679 as select v12, v31 from aggJoin4480434926203662049 join aggView5619110282312741960 using(v1);
create or replace view aggView7721958289503169070 as select v12, MIN(v31) as v31 from aggJoin2296871370449718679 group by v12;
create or replace view aggJoin2216271531951270751 as select keyword_id as v18, v31 from movie_keyword as mk, aggView7721958289503169070 where mk.movie_id=aggView7721958289503169070.v12;
create or replace view aggView9197230018627630687 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin176516787981516476 as select v31 from aggJoin2216271531951270751 join aggView9197230018627630687 using(v18);
select MIN(v31) as v31 from aggJoin176516787981516476;
