create or replace view aggView2027963949408465230 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin5502607079325204325 as select movie_id as v12 from movie_companies as mc, aggView2027963949408465230 where mc.company_id=aggView2027963949408465230.v1;
create or replace view aggView4193268921793989712 as select v12 from aggJoin5502607079325204325 group by v12;
create or replace view aggJoin5471895478856547412 as select id as v12, title as v20 from title as t, aggView4193268921793989712 where t.id=aggView4193268921793989712.v12;
create or replace view aggView1263093062692673138 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3671929154898239181 as select movie_id as v12 from movie_keyword as mk, aggView1263093062692673138 where mk.keyword_id=aggView1263093062692673138.v18;
create or replace view aggView5741650453595459182 as select v12, MIN(v20) as v31 from aggJoin5471895478856547412 group by v12;
create or replace view aggJoin5119766414455717397 as select v31 from aggJoin3671929154898239181 join aggView5741650453595459182 using(v12);
select MIN(v31) as v31 from aggJoin5119766414455717397;
