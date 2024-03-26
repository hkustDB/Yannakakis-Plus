create or replace view aggView9211410825293928025 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin6692719936607066758 as select movie_id as v23, v35 from movie_keyword as mk, aggView9211410825293928025 where mk.keyword_id=aggView9211410825293928025.v8;
create or replace view aggView8291829124826134744 as select v23, MIN(v35) as v35 from aggJoin6692719936607066758 group by v23;
create or replace view aggJoin5821710226761115307 as select id as v23, title as v24, v35 from title as t, aggView8291829124826134744 where t.id=aggView8291829124826134744.v23 and production_year>2000;
create or replace view aggView4260540939079049627 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin5821710226761115307 group by v23;
create or replace view aggJoin2778734793437010670 as select person_id as v14, v35, v37 from cast_info as ci, aggView4260540939079049627 where ci.movie_id=aggView4260540939079049627.v23;
create or replace view aggView3233634992145781777 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin2778734793437010670 group by v14;
create or replace view aggJoin6849171461661387935 as select name as v15, v35, v37 from name as n, aggView3233634992145781777 where n.id=aggView3233634992145781777.v14;
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin6849171461661387935;
