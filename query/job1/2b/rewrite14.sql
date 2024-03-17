create or replace view aggView915540507763327807 as select id as v12, title as v31 from title as t;
create or replace view aggJoin7647334840280082379 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView915540507763327807 where mc.movie_id=aggView915540507763327807.v12;
create or replace view aggView5204598452235493421 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin4811932321284471406 as select v12, v31 from aggJoin7647334840280082379 join aggView5204598452235493421 using(v1);
create or replace view aggView2994254640652340838 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin4657830929032326663 as select movie_id as v12 from movie_keyword as mk, aggView2994254640652340838 where mk.keyword_id=aggView2994254640652340838.v18;
create or replace view aggView8990973565720490778 as select v12 from aggJoin4657830929032326663 group by v12;
create or replace view aggJoin4740135976035346366 as select v31 as v31 from aggJoin4811932321284471406 join aggView8990973565720490778 using(v12);
select MIN(v31) as v31 from aggJoin4740135976035346366;
