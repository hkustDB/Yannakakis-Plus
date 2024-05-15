create or replace view aggView1733603361928423589 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin5364563719874322381 as select movie_id as v23, v35 from movie_keyword as mk, aggView1733603361928423589 where mk.keyword_id=aggView1733603361928423589.v8;
create or replace view aggView5972406987567283982 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin6365566521358487733 as select v23, v35, v37 from aggJoin5364563719874322381 join aggView5972406987567283982 using(v23);
create or replace view aggView1318034322421783052 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3437720855841566312 as select movie_id as v23, v36 from cast_info as ci, aggView1318034322421783052 where ci.person_id=aggView1318034322421783052.v14;
create or replace view aggView2197020480746474606 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin6365566521358487733 group by v23;
create or replace view aggJoin6334263749712350583 as select v36 as v36, v35, v37 from aggJoin3437720855841566312 join aggView2197020480746474606 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6334263749712350583;
