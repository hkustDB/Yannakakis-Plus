create or replace view aggView4835882195573887180 as select id as v12, title as v31 from title as t;
create or replace view aggJoin8181986048105618935 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView4835882195573887180 where mk.movie_id=aggView4835882195573887180.v12;
create or replace view aggView7885759505268579497 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3324692120860227777 as select v12, v31 from aggJoin8181986048105618935 join aggView7885759505268579497 using(v18);
create or replace view aggView1673457845373169641 as select v12, MIN(v31) as v31 from aggJoin3324692120860227777 group by v12;
create or replace view aggJoin4352388872698900144 as select company_id as v1, v31 from movie_companies as mc, aggView1673457845373169641 where mc.movie_id=aggView1673457845373169641.v12;
create or replace view aggView7994021739841557265 as select v1, MIN(v31) as v31 from aggJoin4352388872698900144 group by v1;
create or replace view aggJoin1345794083043816798 as select country_code as v3, v31 from company_name as cn, aggView7994021739841557265 where cn.id=aggView7994021739841557265.v1 and country_code= '[nl]';
select MIN(v31) as v31 from aggJoin1345794083043816798;
