create or replace view aggView3939847543970892883 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin8432815201074992083 as select movie_id as v23, v35 from movie_keyword as mk, aggView3939847543970892883 where mk.keyword_id=aggView3939847543970892883.v8;
create or replace view aggView7293742498658681160 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin3784671901164339994 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView7293742498658681160 where ci.movie_id=aggView7293742498658681160.v23;
create or replace view aggView8323436428778830735 as select v23, MIN(v35) as v35 from aggJoin8432815201074992083 group by v23,v35;
create or replace view aggJoin8385655846111557779 as select v14, v37 as v37, v35 from aggJoin3784671901164339994 join aggView8323436428778830735 using(v23);
create or replace view aggView8746083122259645763 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2060667289875047979 as select v37, v35, v36 from aggJoin8385655846111557779 join aggView8746083122259645763 using(v14);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin2060667289875047979;
