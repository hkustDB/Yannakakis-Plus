create or replace view aggView1166584747045150426 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin1466619020759255902 as select movie_id as v12 from movie_companies as mc, aggView1166584747045150426 where mc.company_id=aggView1166584747045150426.v1;
create or replace view aggView2213756344993498026 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1654880584183112231 as select movie_id as v12 from movie_keyword as mk, aggView2213756344993498026 where mk.keyword_id=aggView2213756344993498026.v18;
create or replace view aggView3184566400564681512 as select v12 from aggJoin1654880584183112231 group by v12;
create or replace view aggJoin1452332448061425291 as select id as v12, title as v20 from title as t, aggView3184566400564681512 where t.id=aggView3184566400564681512.v12;
create or replace view aggView6516655013233118606 as select v12, MIN(v20) as v31 from aggJoin1452332448061425291 group by v12;
create or replace view aggJoin2035030275272028288 as select v31 from aggJoin1466619020759255902 join aggView6516655013233118606 using(v12);
select MIN(v31) as v31 from aggJoin2035030275272028288;
