create or replace view aggView4621329196756905653 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin8126035492750730269 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView4621329196756905653 where mk.movie_id=aggView4621329196756905653.v12;
create or replace view aggView5468792253503724578 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7700229011932280389 as select v12 from aggJoin8126035492750730269 join aggView5468792253503724578 using(v1);
create or replace view aggView5393935514244595598 as select v12 from aggJoin7700229011932280389 group by v12;
create or replace view aggJoin4544786666607923393 as select title as v13, production_year as v16 from title as t, aggView5393935514244595598 where t.id=aggView5393935514244595598.v12 and production_year>2010;
create or replace view aggView8080809103623787662 as select v13 from aggJoin4544786666607923393 group by v13;
select MIN(v13) as v24 from aggView8080809103623787662;
