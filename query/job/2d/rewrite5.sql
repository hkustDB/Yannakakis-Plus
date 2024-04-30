create or replace view aggView8924803797979809092 as select id as v12, title as v31 from title as t;
create or replace view aggJoin5376972586932932893 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView8924803797979809092 where mk.movie_id=aggView8924803797979809092.v12;
create or replace view aggView2039295655444614019 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin1402882778156214646 as select movie_id as v12 from movie_companies as mc, aggView2039295655444614019 where mc.company_id=aggView2039295655444614019.v1;
create or replace view aggView8947092563407362469 as select v12 from aggJoin1402882778156214646 group by v12;
create or replace view aggJoin591154856458803711 as select v18, v31 as v31 from aggJoin5376972586932932893 join aggView8947092563407362469 using(v12);
create or replace view aggView213374713366582328 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin46502609733401347 as select v31 from aggJoin591154856458803711 join aggView213374713366582328 using(v18);
select MIN(v31) as v31 from aggJoin46502609733401347;
