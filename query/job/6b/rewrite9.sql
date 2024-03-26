create or replace view aggView7179828480158598784 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin5822465465631887941 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView7179828480158598784 where mk.movie_id=aggView7179828480158598784.v23;
create or replace view aggView4705955607827945697 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin2616626498710585049 as select v23, v37, v35 from aggJoin5822465465631887941 join aggView4705955607827945697 using(v8);
create or replace view aggView1332195826070632296 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin6462205210448490567 as select movie_id as v23, v36 from cast_info as ci, aggView1332195826070632296 where ci.person_id=aggView1332195826070632296.v14;
create or replace view aggView3600019332075818248 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin2616626498710585049 group by v23;
create or replace view aggJoin6935895926019881794 as select v36 as v36, v37, v35 from aggJoin6462205210448490567 join aggView3600019332075818248 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6935895926019881794;
