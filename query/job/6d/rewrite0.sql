create or replace view aggView360232082669658626 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin6414289935325458824 as select movie_id as v23, v35 from movie_keyword as mk, aggView360232082669658626 where mk.keyword_id=aggView360232082669658626.v8;
create or replace view aggView8157479020771337582 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin1526990364300237234 as select v23, v35, v37 from aggJoin6414289935325458824 join aggView8157479020771337582 using(v23);
create or replace view aggView1075182824914004874 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin1526990364300237234 group by v23;
create or replace view aggJoin2204616549740524022 as select person_id as v14, v35, v37 from cast_info as ci, aggView1075182824914004874 where ci.movie_id=aggView1075182824914004874.v23;
create or replace view aggView538719180147476978 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7581088367319001329 as select v35, v37, v36 from aggJoin2204616549740524022 join aggView538719180147476978 using(v14);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin7581088367319001329;
