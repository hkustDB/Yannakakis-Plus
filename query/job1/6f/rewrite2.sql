create or replace view aggView1112208434104794737 as select id as v14, name as v36 from name as n;
create or replace view aggJoin2621756530238300116 as select movie_id as v23, v36 from cast_info as ci, aggView1112208434104794737 where ci.person_id=aggView1112208434104794737.v14;
create or replace view aggView8563045239842674873 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin8392696772898755631 as select v23, v36 from aggJoin2621756530238300116 join aggView8563045239842674873 using(v23);
create or replace view aggView5802141106311259193 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin6872960976505225258 as select movie_id as v23, v35 from movie_keyword as mk, aggView5802141106311259193 where mk.keyword_id=aggView5802141106311259193.v8;
create or replace view aggView4011251589267361530 as select v23, MIN(v36) as v36 from aggJoin8392696772898755631 group by v23;
create or replace view aggJoin4133154987710707111 as select v35 as v35, v36 from aggJoin6872960976505225258 join aggView4011251589267361530 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4133154987710707111;
