create or replace view aggView4916304203033838087 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin411547511831809100 as select movie_id as v23, v35 from movie_keyword as mk, aggView4916304203033838087 where mk.keyword_id=aggView4916304203033838087.v8;
create or replace view aggView2414736366024827850 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin5430538250367582962 as select v23, v35 from aggJoin411547511831809100 join aggView2414736366024827850 using(v23);
create or replace view aggView6762454496828739445 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin6197115633937897446 as select movie_id as v23, v36 from cast_info as ci, aggView6762454496828739445 where ci.person_id=aggView6762454496828739445.v14;
create or replace view aggView5513237466254170848 as select v23, MIN(v35) as v35 from aggJoin5430538250367582962 group by v23;
create or replace view aggJoin1529917498387040606 as select v36 as v36, v35 from aggJoin6197115633937897446 join aggView5513237466254170848 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1529917498387040606;
