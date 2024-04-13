create or replace view aggView6915152730589318198 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin436381889945845984 as select movie_id as v23, v35 from movie_keyword as mk, aggView6915152730589318198 where mk.keyword_id=aggView6915152730589318198.v8;
create or replace view aggView1747659102066041278 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin5093988554268317603 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView1747659102066041278 where ci.movie_id=aggView1747659102066041278.v23;
create or replace view aggView1320743532559579059 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin9112590110478341010 as select v23, v37, v36 from aggJoin5093988554268317603 join aggView1320743532559579059 using(v14);
create or replace view aggView4189195308782519854 as select v23, MIN(v35) as v35 from aggJoin436381889945845984 group by v23,v35;
create or replace view aggJoin3571117807025021663 as select v37 as v37, v36 as v36, v35 from aggJoin9112590110478341010 join aggView4189195308782519854 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3571117807025021663;
