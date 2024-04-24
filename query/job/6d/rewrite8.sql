create or replace view aggView8927509143027455463 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin2728276756124394228 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView8927509143027455463 where mk.movie_id=aggView8927509143027455463.v23;
create or replace view aggView5179996279529263150 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin8209965817582422974 as select v23, v37, v35 from aggJoin2728276756124394228 join aggView5179996279529263150 using(v8);
create or replace view aggView4163975356285828969 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1364654058654410774 as select movie_id as v23, v36 from cast_info as ci, aggView4163975356285828969 where ci.person_id=aggView4163975356285828969.v14;
create or replace view aggView5170336130176475241 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin8209965817582422974 group by v23,v35,v37;
create or replace view aggJoin4306249617199382707 as select v36 as v36, v37, v35 from aggJoin1364654058654410774 join aggView5170336130176475241 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4306249617199382707;
