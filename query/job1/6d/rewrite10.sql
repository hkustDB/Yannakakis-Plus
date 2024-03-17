create or replace view aggView7610472427478596911 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3269445529730575651 as select movie_id as v23, v35 from movie_keyword as mk, aggView7610472427478596911 where mk.keyword_id=aggView7610472427478596911.v8;
create or replace view aggView4553555558313329964 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7264336475970290684 as select movie_id as v23, v36 from cast_info as ci, aggView4553555558313329964 where ci.person_id=aggView4553555558313329964.v14;
create or replace view aggView5503633057104639669 as select v23, MIN(v35) as v35 from aggJoin3269445529730575651 group by v23;
create or replace view aggJoin6364986722938736348 as select id as v23, title as v24, v35 from title as t, aggView5503633057104639669 where t.id=aggView5503633057104639669.v23 and production_year>2000;
create or replace view aggView8322298828891575468 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin6364986722938736348 group by v23;
create or replace view aggJoin4821739963502326719 as select v36 as v36, v35, v37 from aggJoin7264336475970290684 join aggView8322298828891575468 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4821739963502326719;
