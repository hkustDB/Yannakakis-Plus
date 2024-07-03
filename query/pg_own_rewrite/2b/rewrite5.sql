create or replace view aggView3510487864370201281 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin1138710160340693297 as select movie_id as v12 from movie_companies as mc, aggView3510487864370201281 where mc.company_id=aggView3510487864370201281.v1;
create or replace view aggView3926837243387599812 as select v12 from aggJoin1138710160340693297 group by v12;
create or replace view aggJoin1612018093741066800 as select movie_id as v12, keyword_id as v18 from movie_keyword as mk, aggView3926837243387599812 where mk.movie_id=aggView3926837243387599812.v12;
create or replace view aggView2593922562716745964 as select id as v12, title as v31 from title as t;
create or replace view aggJoin848169205673824399 as select v18, v31 from aggJoin1612018093741066800 join aggView2593922562716745964 using(v12);
create or replace view aggView5137621216679966801 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5727791780180996898 as select v31 from aggJoin848169205673824399 join aggView5137621216679966801 using(v18);
select MIN(v31) as v31 from aggJoin5727791780180996898;
