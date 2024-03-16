create or replace view aggView4683621839447590875 as select id as v12, title as v31 from title as t;
create or replace view aggJoin7261899898870238769 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView4683621839447590875 where mk.movie_id=aggView4683621839447590875.v12;
create or replace view aggView3419988808579707947 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin8951182848274602687 as select movie_id as v12 from movie_companies as mc, aggView3419988808579707947 where mc.company_id=aggView3419988808579707947.v1;
create or replace view aggView1482999488344837161 as select v12 from aggJoin8951182848274602687 group by v12;
create or replace view aggJoin6249739117254890433 as select v18, v31 as v31 from aggJoin7261899898870238769 join aggView1482999488344837161 using(v12);
create or replace view aggView721469194125655042 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2495334992060965127 as select v31 from aggJoin6249739117254890433 join aggView721469194125655042 using(v18);
select MIN(v31) as v31 from aggJoin2495334992060965127;
