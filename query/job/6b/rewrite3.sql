create or replace view aggView3756603412727274566 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3938709087490377379 as select movie_id as v23, v36 from cast_info as ci, aggView3756603412727274566 where ci.person_id=aggView3756603412727274566.v14;
create or replace view aggView7358225221701102172 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin6527999150202972253 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView7358225221701102172 where mk.movie_id=aggView7358225221701102172.v23;
create or replace view aggView2802719746497773972 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin4911511985039242375 as select v23, v37, v35 from aggJoin6527999150202972253 join aggView2802719746497773972 using(v8);
create or replace view aggView5600957609691070472 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin4911511985039242375 group by v23,v37,v35;
create or replace view aggJoin40237389619334247 as select v36 as v36, v37, v35 from aggJoin3938709087490377379 join aggView5600957609691070472 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin40237389619334247;
