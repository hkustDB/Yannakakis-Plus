create or replace view aggView8657644606529589031 as select id as v12, title as v31 from title as t;
create or replace view aggJoin831950317942276523 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView8657644606529589031 where mc.movie_id=aggView8657644606529589031.v12;
create or replace view aggView5182739580200328895 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin1352849739406927288 as select v12, v31 from aggJoin831950317942276523 join aggView5182739580200328895 using(v1);
create or replace view aggView6054603654128002737 as select v12, MIN(v31) as v31 from aggJoin1352849739406927288 group by v12;
create or replace view aggJoin2949433648809676463 as select keyword_id as v18, v31 from movie_keyword as mk, aggView6054603654128002737 where mk.movie_id=aggView6054603654128002737.v12;
create or replace view aggView5921161724966492543 as select v18, MIN(v31) as v31 from aggJoin2949433648809676463 group by v18;
create or replace view aggJoin3793085705179346457 as select keyword as v9, v31 from keyword as k, aggView5921161724966492543 where k.id=aggView5921161724966492543.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin3793085705179346457;
