create or replace view aggView9070736703005127631 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin44088686516479295 as select movie_id as v12 from movie_companies as mc, aggView9070736703005127631 where mc.company_id=aggView9070736703005127631.v1;
create or replace view aggView6817549691883098141 as select v12 from aggJoin44088686516479295 group by v12;
create or replace view aggJoin7598355674908563941 as select id as v12, title as v20 from title as t, aggView6817549691883098141 where t.id=aggView6817549691883098141.v12;
create or replace view aggView5471117249269189353 as select v12, MIN(v20) as v31 from aggJoin7598355674908563941 group by v12;
create or replace view aggJoin4716708431286814293 as select keyword_id as v18, v31 from movie_keyword as mk, aggView5471117249269189353 where mk.movie_id=aggView5471117249269189353.v12;
create or replace view aggView1399223808580427037 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1132501581949532943 as select v31 from aggJoin4716708431286814293 join aggView1399223808580427037 using(v18);
select MIN(v31) as v31 from aggJoin1132501581949532943;
