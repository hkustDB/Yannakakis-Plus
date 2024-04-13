create or replace view aggView8954716751945683334 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin5975351488818998433 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView8954716751945683334 where mk.movie_id=aggView8954716751945683334.v23;
create or replace view aggView1727462813199345001 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin8962822059147274219 as select v23, v37, v35 from aggJoin5975351488818998433 join aggView1727462813199345001 using(v8);
create or replace view aggView274982177829606043 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2752739425522973243 as select movie_id as v23, v36 from cast_info as ci, aggView274982177829606043 where ci.person_id=aggView274982177829606043.v14;
create or replace view aggView2885141871264200092 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin8962822059147274219 group by v23,v35,v37;
create or replace view aggJoin8420263921850523062 as select v36 as v36, v37, v35 from aggJoin2752739425522973243 join aggView2885141871264200092 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8420263921850523062;
