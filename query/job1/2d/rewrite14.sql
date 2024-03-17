create or replace view aggView8087074653184406269 as select id as v12, title as v31 from title as t;
create or replace view aggJoin7914615973941869231 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView8087074653184406269 where mk.movie_id=aggView8087074653184406269.v12;
create or replace view aggView9107443248356579447 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7901717924786933770 as select v12, v31 from aggJoin7914615973941869231 join aggView9107443248356579447 using(v18);
create or replace view aggView6917313136307765309 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin3002495318484978688 as select movie_id as v12 from movie_companies as mc, aggView6917313136307765309 where mc.company_id=aggView6917313136307765309.v1;
create or replace view aggView2227087455150680555 as select v12 from aggJoin3002495318484978688 group by v12;
create or replace view aggJoin4234290960251109200 as select v31 as v31 from aggJoin7901717924786933770 join aggView2227087455150680555 using(v12);
select MIN(v31) as v31 from aggJoin4234290960251109200;
