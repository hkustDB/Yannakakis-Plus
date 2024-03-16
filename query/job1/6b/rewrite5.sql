create or replace view aggView2638146200283068158 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1268554471082769921 as select movie_id as v23, v35 from movie_keyword as mk, aggView2638146200283068158 where mk.keyword_id=aggView2638146200283068158.v8;
create or replace view aggView1648891658494573835 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin1564376746172733634 as select v23, v35 from aggJoin1268554471082769921 join aggView1648891658494573835 using(v23);
create or replace view aggView5010181563587845959 as select v23, MIN(v35) as v35 from aggJoin1564376746172733634 group by v23;
create or replace view aggJoin4676216546620312650 as select person_id as v14, v35 from cast_info as ci, aggView5010181563587845959 where ci.movie_id=aggView5010181563587845959.v23;
create or replace view aggView4513318840553726649 as select v14, MIN(v35) as v35 from aggJoin4676216546620312650 group by v14;
create or replace view aggJoin466251509157284276 as select name as v15, v35 from name as n, aggView4513318840553726649 where n.id=aggView4513318840553726649.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin466251509157284276;
