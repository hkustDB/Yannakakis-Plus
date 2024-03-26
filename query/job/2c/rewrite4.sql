create or replace view aggView8039567968300295062 as select id as v12, title as v31 from title as t;
create or replace view aggJoin2689206002327547795 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView8039567968300295062 where mc.movie_id=aggView8039567968300295062.v12;
create or replace view aggView8736134044991706454 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin4988497581369965853 as select v12, v31 from aggJoin2689206002327547795 join aggView8736134044991706454 using(v1);
create or replace view aggView4749756243952778362 as select v12, MIN(v31) as v31 from aggJoin4988497581369965853 group by v12;
create or replace view aggJoin5084130170934728864 as select keyword_id as v18, v31 from movie_keyword as mk, aggView4749756243952778362 where mk.movie_id=aggView4749756243952778362.v12;
create or replace view aggView8338476184740458294 as select v18, MIN(v31) as v31 from aggJoin5084130170934728864 group by v18;
create or replace view aggJoin1566961776333515994 as select keyword as v9, v31 from keyword as k, aggView8338476184740458294 where k.id=aggView8338476184740458294.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin1566961776333515994;
