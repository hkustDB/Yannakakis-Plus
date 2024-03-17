create or replace view aggView418907794582865534 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin8708066970234681874 as select movie_id as v12 from movie_companies as mc, aggView418907794582865534 where mc.company_id=aggView418907794582865534.v1;
create or replace view aggView7569860425257219983 as select v12 from aggJoin8708066970234681874 group by v12;
create or replace view aggJoin7016698785342564747 as select id as v12, title as v20 from title as t, aggView7569860425257219983 where t.id=aggView7569860425257219983.v12;
create or replace view aggView8688974787092804383 as select v12, MIN(v20) as v31 from aggJoin7016698785342564747 group by v12;
create or replace view aggJoin4767213369334927125 as select keyword_id as v18, v31 from movie_keyword as mk, aggView8688974787092804383 where mk.movie_id=aggView8688974787092804383.v12;
create or replace view aggView780511782552720859 as select v18, MIN(v31) as v31 from aggJoin4767213369334927125 group by v18;
create or replace view aggJoin7174411072541919159 as select keyword as v9, v31 from keyword as k, aggView780511782552720859 where k.id=aggView780511782552720859.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin7174411072541919159;
