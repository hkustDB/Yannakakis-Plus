create or replace view aggView5188840115970474799 as select id as v12, title as v31 from title as t;
create or replace view aggJoin243499060747314331 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView5188840115970474799 where mc.movie_id=aggView5188840115970474799.v12;
create or replace view aggView4476342849344377134 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin1068721627410785599 as select v12, v31 from aggJoin243499060747314331 join aggView4476342849344377134 using(v1);
create or replace view aggView3329413974961168212 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin464226591138696931 as select movie_id as v12 from movie_keyword as mk, aggView3329413974961168212 where mk.keyword_id=aggView3329413974961168212.v18;
create or replace view aggView8604383057464825079 as select v12, MIN(v31) as v31 from aggJoin1068721627410785599 group by v12;
create or replace view aggJoin403476397316543133 as select v31 from aggJoin464226591138696931 join aggView8604383057464825079 using(v12);
select MIN(v31) as v31 from aggJoin403476397316543133;
