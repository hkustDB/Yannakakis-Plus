create or replace view aggView500977942903959490 as select id as v12, title as v31 from title as t;
create or replace view aggJoin9195404015832025446 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView500977942903959490 where mc.movie_id=aggView500977942903959490.v12;
create or replace view aggView113561417935951997 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin4776584630340502440 as select v12, v31 from aggJoin9195404015832025446 join aggView113561417935951997 using(v1);
create or replace view aggView3425205906249474339 as select v12, MIN(v31) as v31 from aggJoin4776584630340502440 group by v12,v31;
create or replace view aggJoin4844637210837543435 as select keyword_id as v18, v31 from movie_keyword as mk, aggView3425205906249474339 where mk.movie_id=aggView3425205906249474339.v12;
create or replace view aggView6877884449567571407 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8608174152862798035 as select v31 from aggJoin4844637210837543435 join aggView6877884449567571407 using(v18);
select MIN(v31) as v31 from aggJoin8608174152862798035;
