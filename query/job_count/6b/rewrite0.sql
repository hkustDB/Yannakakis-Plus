create or replace view aggView943033903456465364 as select id as v23 from title as t where production_year>2014;
create or replace view aggJoin3209523351687696657 as select movie_id as v23, keyword_id as v8 from movie_keyword as mk, aggView943033903456465364 where mk.movie_id=aggView943033903456465364.v23;
create or replace view aggView7562724761053211037 as select id as v14 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3009315221288259781 as select movie_id as v23 from cast_info as ci, aggView7562724761053211037 where ci.person_id=aggView7562724761053211037.v14;
create or replace view aggView1175932082501099784 as select id as v8 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin8959947131900167575 as select v23 from aggJoin3209523351687696657 join aggView1175932082501099784 using(v8);
create or replace view aggView4602354587724808018 as select v23, COUNT(*) as annot from aggJoin8959947131900167575 group by v23;
create or replace view aggJoin3073783723696578344 as select annot from aggJoin3009315221288259781 join aggView4602354587724808018 using(v23);
select SUM(annot) as v35 from aggJoin3073783723696578344;
