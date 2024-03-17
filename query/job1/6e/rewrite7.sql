create or replace view aggView4114642162734517967 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin8742860565892634425 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView4114642162734517967 where ci.movie_id=aggView4114642162734517967.v23;
create or replace view aggView1553135148912613591 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4971101239305935741 as select v23, v37, v36 from aggJoin8742860565892634425 join aggView1553135148912613591 using(v14);
create or replace view aggView6786587864727365861 as select v23, MIN(v37) as v37, MIN(v36) as v36 from aggJoin4971101239305935741 group by v23;
create or replace view aggJoin5774051476998375012 as select keyword_id as v8, v37, v36 from movie_keyword as mk, aggView6786587864727365861 where mk.movie_id=aggView6786587864727365861.v23;
create or replace view aggView4069136147656050533 as select v8, MIN(v37) as v37, MIN(v36) as v36 from aggJoin5774051476998375012 group by v8;
create or replace view aggJoin3854195642562266231 as select keyword as v9, v37, v36 from keyword as k, aggView4069136147656050533 where k.id=aggView4069136147656050533.v8 and keyword= 'marvel-cinematic-universe';
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3854195642562266231;
