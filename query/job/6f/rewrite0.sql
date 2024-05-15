create or replace view aggView6283738869622018331 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1762517407669751380 as select movie_id as v23, v35 from movie_keyword as mk, aggView6283738869622018331 where mk.keyword_id=aggView6283738869622018331.v8;
create or replace view aggView8076562835512712885 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin7214729354593776231 as select v23, v35, v37 from aggJoin1762517407669751380 join aggView8076562835512712885 using(v23);
create or replace view aggView3862351446846488518 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin7214729354593776231 group by v23;
create or replace view aggJoin3515152592899620674 as select person_id as v14, v35, v37 from cast_info as ci, aggView3862351446846488518 where ci.movie_id=aggView3862351446846488518.v23;
create or replace view aggView8096382242365400516 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin3515152592899620674 group by v14;
create or replace view aggJoin7272450736942455337 as select name as v15, v35, v37 from name as n, aggView8096382242365400516 where n.id=aggView8096382242365400516.v14;
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin7272450736942455337;
