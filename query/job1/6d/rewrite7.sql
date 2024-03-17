create or replace view aggView6790859932539609284 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1501547584150525899 as select movie_id as v23, v35 from movie_keyword as mk, aggView6790859932539609284 where mk.keyword_id=aggView6790859932539609284.v8;
create or replace view aggView5863910101775429558 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin2349359553807218161 as select v23, v35, v37 from aggJoin1501547584150525899 join aggView5863910101775429558 using(v23);
create or replace view aggView4515623160811763453 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3417250085520828259 as select movie_id as v23, v36 from cast_info as ci, aggView4515623160811763453 where ci.person_id=aggView4515623160811763453.v14;
create or replace view aggView9031057162412274095 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin2349359553807218161 group by v23;
create or replace view aggJoin4037053945005417154 as select v36 as v36, v35, v37 from aggJoin3417250085520828259 join aggView9031057162412274095 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4037053945005417154;
