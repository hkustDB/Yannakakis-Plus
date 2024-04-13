create or replace view aggView1297725410234652200 as select id as v12, title as v31 from title as t;
create or replace view aggJoin7412364347678263580 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView1297725410234652200 where mc.movie_id=aggView1297725410234652200.v12;
create or replace view aggView3818512099997411498 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin8892550154134063448 as select v12, v31 from aggJoin7412364347678263580 join aggView3818512099997411498 using(v1);
create or replace view aggView4981043167223344261 as select v12, MIN(v31) as v31 from aggJoin8892550154134063448 group by v12,v31;
create or replace view aggJoin2129203481325415044 as select keyword_id as v18, v31 from movie_keyword as mk, aggView4981043167223344261 where mk.movie_id=aggView4981043167223344261.v12;
create or replace view aggView4330506630057387301 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin4169572439183650939 as select v31 from aggJoin2129203481325415044 join aggView4330506630057387301 using(v18);
select MIN(v31) as v31 from aggJoin4169572439183650939;
