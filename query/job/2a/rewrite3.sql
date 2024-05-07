create or replace view aggView3041706668837339047 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6668958102688051109 as select movie_id as v12 from movie_keyword as mk, aggView3041706668837339047 where mk.keyword_id=aggView3041706668837339047.v18;
create or replace view aggView8869318979674841323 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin6006410538656218613 as select movie_id as v12 from movie_companies as mc, aggView8869318979674841323 where mc.company_id=aggView8869318979674841323.v1;
create or replace view aggView9199417329338473800 as select v12 from aggJoin6006410538656218613 group by v12;
create or replace view aggJoin3621332729696708410 as select id as v12, title as v20 from title as t, aggView9199417329338473800 where t.id=aggView9199417329338473800.v12;
create or replace view aggView8476719415956028757 as select v12, MIN(v20) as v31 from aggJoin3621332729696708410 group by v12;
create or replace view aggJoin6705007579354714154 as select v31 from aggJoin6668958102688051109 join aggView8476719415956028757 using(v12);
select MIN(v31) as v31 from aggJoin6705007579354714154;
