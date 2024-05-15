create or replace view aggView1247825597667171497 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin5656180639502969052 as select movie_id as v23, v35 from movie_keyword as mk, aggView1247825597667171497 where mk.keyword_id=aggView1247825597667171497.v8;
create or replace view aggView2811951604131269782 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin5730771417329791489 as select v23, v35, v37 from aggJoin5656180639502969052 join aggView2811951604131269782 using(v23);
create or replace view aggView3845242601131435733 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin5730771417329791489 group by v23;
create or replace view aggJoin3856666674482737488 as select person_id as v14, v35, v37 from cast_info as ci, aggView3845242601131435733 where ci.movie_id=aggView3845242601131435733.v23;
create or replace view aggView6834650941135870074 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8169119908777668933 as select v35, v37, v36 from aggJoin3856666674482737488 join aggView6834650941135870074 using(v14);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8169119908777668933;
