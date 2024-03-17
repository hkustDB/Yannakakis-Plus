create or replace view aggView2020039998741059292 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1440110353227827611 as select movie_id as v12 from movie_keyword as mk, aggView2020039998741059292 where mk.keyword_id=aggView2020039998741059292.v18;
create or replace view aggView3829607366803770961 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin4331959436407840300 as select movie_id as v12 from movie_companies as mc, aggView3829607366803770961 where mc.company_id=aggView3829607366803770961.v1;
create or replace view aggView5168931773033951224 as select v12 from aggJoin4331959436407840300 group by v12;
create or replace view aggJoin9136732625734771216 as select v12 from aggJoin1440110353227827611 join aggView5168931773033951224 using(v12);
create or replace view aggView622404360409983626 as select v12 from aggJoin9136732625734771216 group by v12;
create or replace view aggJoin1928149984987739499 as select title as v20 from title as t, aggView622404360409983626 where t.id=aggView622404360409983626.v12;
select MIN(v20) as v31 from aggJoin1928149984987739499;
