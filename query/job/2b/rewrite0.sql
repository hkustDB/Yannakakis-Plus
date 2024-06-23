create or replace view aggView7184073989917217410 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6139174536501289571 as select movie_id as v12 from movie_keyword as mk, aggView7184073989917217410 where mk.keyword_id=aggView7184073989917217410.v18;
create or replace view aggView8082796638431109008 as select v12 from aggJoin6139174536501289571 group by v12;
create or replace view aggJoin4651525979235726714 as select id as v12, title as v20 from title as t, aggView8082796638431109008 where t.id=aggView8082796638431109008.v12;
create or replace view aggView4054788738692507289 as select v12, MIN(v20) as v31 from aggJoin4651525979235726714 group by v12;
create or replace view aggJoin604725590975333828 as select company_id as v1, v31 from movie_companies as mc, aggView4054788738692507289 where mc.movie_id=aggView4054788738692507289.v12;
create or replace view aggView6573539752664751198 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin1134898820838121709 as select v31 from aggJoin604725590975333828 join aggView6573539752664751198 using(v1);
select MIN(v31) as v31 from aggJoin1134898820838121709;
