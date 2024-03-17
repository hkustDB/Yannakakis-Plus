create or replace view aggView2899664019680966303 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin1049694714505063386 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView2899664019680966303 where mk.movie_id=aggView2899664019680966303.v23;
create or replace view aggView1261575273201749744 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin493915706734206703 as select movie_id as v23, v36 from cast_info as ci, aggView1261575273201749744 where ci.person_id=aggView1261575273201749744.v14;
create or replace view aggView6595927785776604786 as select v23, MIN(v36) as v36 from aggJoin493915706734206703 group by v23;
create or replace view aggJoin7893914944614246468 as select v8, v37 as v37, v36 from aggJoin1049694714505063386 join aggView6595927785776604786 using(v23);
create or replace view aggView4576945110306772770 as select v8, MIN(v37) as v37, MIN(v36) as v36 from aggJoin7893914944614246468 group by v8;
create or replace view aggJoin8450872103214537045 as select keyword as v9, v37, v36 from keyword as k, aggView4576945110306772770 where k.id=aggView4576945110306772770.v8 and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8450872103214537045;
