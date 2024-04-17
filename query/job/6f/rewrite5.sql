create or replace view aggView737412921157051619 as select id as v14, name as v36 from name as n;
create or replace view aggJoin8630509708859725104 as select movie_id as v23, v36 from cast_info as ci, aggView737412921157051619 where ci.person_id=aggView737412921157051619.v14;
create or replace view aggView2926516172831198435 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin3852383566486614617 as select v23, v36, v37 from aggJoin8630509708859725104 join aggView2926516172831198435 using(v23);
create or replace view aggView5992677976802730889 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin604434002434034736 as select movie_id as v23, v35 from movie_keyword as mk, aggView5992677976802730889 where mk.keyword_id=aggView5992677976802730889.v8;
create or replace view aggView1020569676125594525 as select v23, MIN(v35) as v35 from aggJoin604434002434034736 group by v23,v35;
create or replace view aggJoin5468529635474159247 as select v36 as v36, v37 as v37, v35 from aggJoin3852383566486614617 join aggView1020569676125594525 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5468529635474159247;
