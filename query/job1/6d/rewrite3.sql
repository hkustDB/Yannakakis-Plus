create or replace view aggView3571721974020483783 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3241438153467317064 as select movie_id as v23, v35 from movie_keyword as mk, aggView3571721974020483783 where mk.keyword_id=aggView3571721974020483783.v8;
create or replace view aggView3828720566175983745 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4703179888929759336 as select movie_id as v23, v36 from cast_info as ci, aggView3828720566175983745 where ci.person_id=aggView3828720566175983745.v14;
create or replace view aggView6096944286395866090 as select v23, MIN(v36) as v36 from aggJoin4703179888929759336 group by v23;
create or replace view aggJoin7052896809865861704 as select id as v23, title as v24, v36 from title as t, aggView6096944286395866090 where t.id=aggView6096944286395866090.v23 and production_year>2000;
create or replace view aggView3362173255289934900 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin7052896809865861704 group by v23;
create or replace view aggJoin7684317209346631127 as select v35 as v35, v36, v37 from aggJoin3241438153467317064 join aggView3362173255289934900 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin7684317209346631127;
