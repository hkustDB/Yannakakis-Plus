create or replace view aggView9030906490591171561 as select id as v12, title as v31 from title as t;
create or replace view aggJoin7640606452371630294 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView9030906490591171561 where mc.movie_id=aggView9030906490591171561.v12;
create or replace view aggView9143824579253165054 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin3089148460001555908 as select v12, v31 from aggJoin7640606452371630294 join aggView9143824579253165054 using(v1);
create or replace view aggView7188333026728527704 as select v12, MIN(v31) as v31 from aggJoin3089148460001555908 group by v12;
create or replace view aggJoin4393554765749508370 as select keyword_id as v18, v31 from movie_keyword as mk, aggView7188333026728527704 where mk.movie_id=aggView7188333026728527704.v12;
create or replace view aggView5383394798454275546 as select v18, MIN(v31) as v31 from aggJoin4393554765749508370 group by v18;
create or replace view aggJoin8044071090632460938 as select keyword as v9, v31 from keyword as k, aggView5383394798454275546 where k.id=aggView5383394798454275546.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin8044071090632460938;
