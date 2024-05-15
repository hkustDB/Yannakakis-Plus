create or replace view aggView4717614985072825364 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin418891801105404691 as select movie_id as v12 from movie_companies as mc, aggView4717614985072825364 where mc.company_id=aggView4717614985072825364.v1;
create or replace view aggView388157766424969989 as select v12 from aggJoin418891801105404691 group by v12;
create or replace view aggJoin6462439147151788228 as select id as v12, title as v20 from title as t, aggView388157766424969989 where t.id=aggView388157766424969989.v12;
create or replace view aggView5580367501683056915 as select v12, MIN(v20) as v31 from aggJoin6462439147151788228 group by v12;
create or replace view aggJoin3115087463339508138 as select keyword_id as v18, v31 from movie_keyword as mk, aggView5580367501683056915 where mk.movie_id=aggView5580367501683056915.v12;
create or replace view aggView4548505161865692565 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6449862225469674729 as select v31 from aggJoin3115087463339508138 join aggView4548505161865692565 using(v18);
select MIN(v31) as v31 from aggJoin6449862225469674729;
