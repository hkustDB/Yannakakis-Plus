create or replace view aggView5282188983251974785 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin7376166269426746484 as select movie_id as v23, v35 from movie_keyword as mk, aggView5282188983251974785 where mk.keyword_id=aggView5282188983251974785.v8;
create or replace view aggView8557975059910609083 as select v23, MIN(v35) as v35 from aggJoin7376166269426746484 group by v23;
create or replace view aggJoin7574780195232208285 as select id as v23, title as v24, v35 from title as t, aggView8557975059910609083 where t.id=aggView8557975059910609083.v23 and production_year>2014;
create or replace view aggView4884725244118745063 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin7574780195232208285 group by v23;
create or replace view aggJoin7713706473523749878 as select person_id as v14, v35, v37 from cast_info as ci, aggView4884725244118745063 where ci.movie_id=aggView4884725244118745063.v23;
create or replace view aggView7144738076244129496 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin7713706473523749878 group by v14;
create or replace view aggJoin2447199615956892056 as select name as v15, v35, v37 from name as n, aggView7144738076244129496 where n.id=aggView7144738076244129496.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin2447199615956892056;
