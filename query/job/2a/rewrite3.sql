create or replace view aggView114285332948452625 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin69591055915856403 as select movie_id as v12 from movie_companies as mc, aggView114285332948452625 where mc.company_id=aggView114285332948452625.v1;
create or replace view aggView8620456994548225099 as select id as v12, title as v31 from title as t;
create or replace view aggJoin5379312504830156395 as select v12, v31 from aggJoin69591055915856403 join aggView8620456994548225099 using(v12);
create or replace view aggView4177328524186795650 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin4288053612092889247 as select movie_id as v12 from movie_keyword as mk, aggView4177328524186795650 where mk.keyword_id=aggView4177328524186795650.v18;
create or replace view aggView5254802637451312655 as select v12, MIN(v31) as v31 from aggJoin5379312504830156395 group by v12;
create or replace view aggJoin4219990047646864902 as select v31 from aggJoin4288053612092889247 join aggView5254802637451312655 using(v12);
select MIN(v31) as v31 from aggJoin4219990047646864902;
