create or replace view aggView599036134337077103 as select id as v25 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1710751824294540121 as select movie_id as v3 from movie_keyword as mk, aggView599036134337077103 where mk.keyword_id=aggView599036134337077103.v25;
create or replace view aggView5801301294317520780 as select v3 from aggJoin1710751824294540121 group by v3;
create or replace view aggJoin5579697645556071042 as select movie_id as v3, company_id as v20 from movie_companies as mc, aggView5801301294317520780 where mc.movie_id=aggView5801301294317520780.v3;
create or replace view aggView4412246425367536766 as select v20, v3 from aggJoin5579697645556071042 group by v20,v3;
create or replace view aggJoin3156144568540835975 as select country_code as v10, v3 from company_name as cn, aggView4412246425367536766 where cn.id=aggView4412246425367536766.v20 and country_code= '[us]';
create or replace view aggView7255665022649773630 as select v3 from aggJoin3156144568540835975 group by v3;
create or replace view aggJoin3824673670963026198 as select id as v3 from title as t, aggView7255665022649773630 where t.id=aggView7255665022649773630.v3;
create or replace view aggView4602054171479317984 as select v3 from aggJoin3824673670963026198 group by v3;
create or replace view aggJoin4844905489606637106 as select person_id as v26, movie_id as v3 from cast_info as ci, aggView4602054171479317984 where ci.movie_id=aggView4602054171479317984.v3;
create or replace view aggView5750846309800955194 as select v26 from aggJoin4844905489606637106 group by v26;
create or replace view aggJoin1996841663324922779 as select name as v27 from name as n, aggView5750846309800955194 where n.id=aggView5750846309800955194.v26;
select MIN(v27) as v47 from aggJoin1996841663324922779;
