create or replace view aggView3157302687940760197 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin4372606286444764111 as select movie_id as v12 from movie_keyword as mk, aggView3157302687940760197 where mk.keyword_id=aggView3157302687940760197.v18;
create or replace view aggView345225044207334503 as select v12 from aggJoin4372606286444764111 group by v12;
create or replace view aggJoin1844104990118865055 as select id as v12, title as v20 from title as t, aggView345225044207334503 where t.id=aggView345225044207334503.v12;
create or replace view aggView8146334131964673022 as select v12, MIN(v20) as v31 from aggJoin1844104990118865055 group by v12;
create or replace view aggJoin2279878351465024530 as select company_id as v1, v31 from movie_companies as mc, aggView8146334131964673022 where mc.movie_id=aggView8146334131964673022.v12;
create or replace view aggView1883088583156206298 as select v1, MIN(v31) as v31 from aggJoin2279878351465024530 group by v1;
create or replace view aggJoin3819299533608517411 as select country_code as v3, v31 from company_name as cn, aggView1883088583156206298 where cn.id=aggView1883088583156206298.v1 and country_code= '[us]';
select MIN(v31) as v31 from aggJoin3819299533608517411;
