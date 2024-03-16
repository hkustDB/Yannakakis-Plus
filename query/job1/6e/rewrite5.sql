create or replace view aggView1530935065382231647 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin190951237361141675 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView1530935065382231647 where ci.movie_id=aggView1530935065382231647.v23;
create or replace view aggView7006160295480358680 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3477207733445136588 as select v23, v37 from aggJoin190951237361141675 join aggView7006160295480358680 using(v14);
create or replace view aggView3492473121018765283 as select v23, MIN(v37) as v37 from aggJoin3477207733445136588 group by v23;
create or replace view aggJoin3323193254748797980 as select keyword_id as v8, v37 from movie_keyword as mk, aggView3492473121018765283 where mk.movie_id=aggView3492473121018765283.v23;
create or replace view aggView6374023838075963467 as select v8, MIN(v37) as v37 from aggJoin3323193254748797980 group by v8;
create or replace view aggJoin5877947425409689511 as select keyword as v9, v37 from keyword as k, aggView6374023838075963467 where k.id=aggView6374023838075963467.v8 and keyword= 'marvel-cinematic-universe';
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5877947425409689511;
