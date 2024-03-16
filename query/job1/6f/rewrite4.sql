create or replace view aggView5587559442950239385 as select id as v14, name as v36 from name as n;
create or replace view aggJoin7045656776671634391 as select movie_id as v23, v36 from cast_info as ci, aggView5587559442950239385 where ci.person_id=aggView5587559442950239385.v14;
create or replace view aggView8441144411060122089 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin2625300100202461803 as select movie_id as v23, v35 from movie_keyword as mk, aggView8441144411060122089 where mk.keyword_id=aggView8441144411060122089.v8;
create or replace view aggView5636089873711702066 as select v23, MIN(v36) as v36 from aggJoin7045656776671634391 group by v23;
create or replace view aggJoin3983214332126198154 as select v23, v35 as v35, v36 from aggJoin2625300100202461803 join aggView5636089873711702066 using(v23);
create or replace view aggView6290197582696252430 as select v23, MIN(v35) as v35, MIN(v36) as v36 from aggJoin3983214332126198154 group by v23;
create or replace view aggJoin8593081926292566372 as select title as v24, v35, v36 from title as t, aggView6290197582696252430 where t.id=aggView6290197582696252430.v23 and production_year>2000;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin8593081926292566372;
