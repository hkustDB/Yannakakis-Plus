create or replace view aggView699333927888006935 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin87629884487391990 as select movie_id as v23, v36 from cast_info as ci, aggView699333927888006935 where ci.person_id=aggView699333927888006935.v14;
create or replace view aggView538627880974183148 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin8480358574610162946 as select movie_id as v23, v35 from movie_keyword as mk, aggView538627880974183148 where mk.keyword_id=aggView538627880974183148.v8;
create or replace view aggView5231344498669863422 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin8856755353648578705 as select v23, v35, v37 from aggJoin8480358574610162946 join aggView5231344498669863422 using(v23);
create or replace view aggView8801413457681148681 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin8856755353648578705 group by v23;
create or replace view aggJoin7656945557530201462 as select v36 as v36, v35, v37 from aggJoin87629884487391990 join aggView8801413457681148681 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin7656945557530201462;
