create or replace view aggView5333140846966381770 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1700181681079413274 as select movie_id as v23, v35 from movie_keyword as mk, aggView5333140846966381770 where mk.keyword_id=aggView5333140846966381770.v8;
create or replace view aggView118291531071922939 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4893137043143719016 as select movie_id as v23, v36 from cast_info as ci, aggView118291531071922939 where ci.person_id=aggView118291531071922939.v14;
create or replace view aggView6439279042404279609 as select v23, MIN(v35) as v35 from aggJoin1700181681079413274 group by v23,v35;
create or replace view aggJoin5571238793456257094 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView6439279042404279609 where t.id=aggView6439279042404279609.v23 and production_year>2014;
create or replace view aggView3585324023469106389 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin5571238793456257094 group by v23,v35;
create or replace view aggJoin1999602297837687956 as select v36 as v36, v35, v37 from aggJoin4893137043143719016 join aggView3585324023469106389 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1999602297837687956;
