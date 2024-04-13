create or replace view aggView1268320988682255617 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin39489677755108371 as select movie_id as v12 from movie_companies as mc, aggView1268320988682255617 where mc.company_id=aggView1268320988682255617.v1;
create or replace view aggView2181831031074518511 as select v12 from aggJoin39489677755108371 group by v12;
create or replace view aggJoin7867981832071281498 as select id as v12, title as v20 from title as t, aggView2181831031074518511 where t.id=aggView2181831031074518511.v12;
create or replace view aggView388920102771556650 as select v12, MIN(v20) as v31 from aggJoin7867981832071281498 group by v12;
create or replace view aggJoin1642457629705618763 as select keyword_id as v18, v31 from movie_keyword as mk, aggView388920102771556650 where mk.movie_id=aggView388920102771556650.v12;
create or replace view aggView6713529051101749390 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2938739117139068104 as select v31 from aggJoin1642457629705618763 join aggView6713529051101749390 using(v18);
select MIN(v31) as v31 from aggJoin2938739117139068104;
