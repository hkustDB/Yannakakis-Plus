create or replace view aggView6663035423013711861 as select id as v12, title as v31 from title as t;
create or replace view aggJoin8147730915775110584 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView6663035423013711861 where mc.movie_id=aggView6663035423013711861.v12;
create or replace view aggView3763862559258592261 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin2426974082196441476 as select v12, v31 from aggJoin8147730915775110584 join aggView3763862559258592261 using(v1);
create or replace view aggView192834585303217506 as select v12, MIN(v31) as v31 from aggJoin2426974082196441476 group by v12;
create or replace view aggJoin5847241388741051372 as select keyword_id as v18, v31 from movie_keyword as mk, aggView192834585303217506 where mk.movie_id=aggView192834585303217506.v12;
create or replace view aggView5607371327458911319 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8386656677269935672 as select v31 from aggJoin5847241388741051372 join aggView5607371327458911319 using(v18);
select MIN(v31) as v31 from aggJoin8386656677269935672;
