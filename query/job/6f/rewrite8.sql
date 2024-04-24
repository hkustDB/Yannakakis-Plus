create or replace view aggView1318841392574142039 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin4130443669000892854 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView1318841392574142039 where mk.movie_id=aggView1318841392574142039.v23;
create or replace view aggView7851607233852152368 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1889246473994569252 as select v23, v37, v35 from aggJoin4130443669000892854 join aggView7851607233852152368 using(v8);
create or replace view aggView8887229947500744904 as select id as v14, name as v36 from name as n;
create or replace view aggJoin5153884780564486067 as select movie_id as v23, v36 from cast_info as ci, aggView8887229947500744904 where ci.person_id=aggView8887229947500744904.v14;
create or replace view aggView4114288461047176469 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin1889246473994569252 group by v23,v35,v37;
create or replace view aggJoin4674340073906254937 as select v36 as v36, v37, v35 from aggJoin5153884780564486067 join aggView4114288461047176469 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4674340073906254937;
