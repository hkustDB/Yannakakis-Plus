create or replace view aggView8268199238582992082 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin7388986126685688048 as select movie_id as v12 from movie_companies as mc, aggView8268199238582992082 where mc.company_id=aggView8268199238582992082.v1;
create or replace view aggView6881823885173888934 as select v12 from aggJoin7388986126685688048 group by v12;
create or replace view aggJoin1229293675343260347 as select id as v12, title as v20 from title as t, aggView6881823885173888934 where t.id=aggView6881823885173888934.v12;
create or replace view aggView4985010645125339660 as select v12, MIN(v20) as v31 from aggJoin1229293675343260347 group by v12;
create or replace view aggJoin1487329129307389118 as select keyword_id as v18, v31 from movie_keyword as mk, aggView4985010645125339660 where mk.movie_id=aggView4985010645125339660.v12;
create or replace view aggView3639611131143967179 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1049523853547949021 as select v31 from aggJoin1487329129307389118 join aggView3639611131143967179 using(v18);
select MIN(v31) as v31 from aggJoin1049523853547949021;
