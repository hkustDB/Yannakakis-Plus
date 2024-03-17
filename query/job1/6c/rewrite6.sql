create or replace view aggView6922895886139254581 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin1975621604295902619 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView6922895886139254581 where mk.movie_id=aggView6922895886139254581.v23;
create or replace view aggView7446637749363268703 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2683068848016634443 as select movie_id as v23, v36 from cast_info as ci, aggView7446637749363268703 where ci.person_id=aggView7446637749363268703.v14;
create or replace view aggView9178824298404856698 as select v23, MIN(v36) as v36 from aggJoin2683068848016634443 group by v23;
create or replace view aggJoin8768812839358094561 as select v8, v37 as v37, v36 from aggJoin1975621604295902619 join aggView9178824298404856698 using(v23);
create or replace view aggView741513446051452022 as select v8, MIN(v37) as v37, MIN(v36) as v36 from aggJoin8768812839358094561 group by v8;
create or replace view aggJoin267764760771329369 as select keyword as v9, v37, v36 from keyword as k, aggView741513446051452022 where k.id=aggView741513446051452022.v8 and keyword= 'marvel-cinematic-universe';
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin267764760771329369;
