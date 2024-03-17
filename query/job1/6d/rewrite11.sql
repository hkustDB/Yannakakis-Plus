create or replace view aggView509398154682189564 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin168098064497146632 as select movie_id as v23, v36 from cast_info as ci, aggView509398154682189564 where ci.person_id=aggView509398154682189564.v14;
create or replace view aggView7392140505554486489 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin2143332381593757783 as select movie_id as v23, v35 from movie_keyword as mk, aggView7392140505554486489 where mk.keyword_id=aggView7392140505554486489.v8;
create or replace view aggView1977323170108104822 as select v23, MIN(v36) as v36 from aggJoin168098064497146632 group by v23;
create or replace view aggJoin7190643614362020323 as select v23, v35 as v35, v36 from aggJoin2143332381593757783 join aggView1977323170108104822 using(v23);
create or replace view aggView2626569798028242279 as select v23, MIN(v35) as v35, MIN(v36) as v36 from aggJoin7190643614362020323 group by v23;
create or replace view aggJoin2074152798978467800 as select title as v24, v35, v36 from title as t, aggView2626569798028242279 where t.id=aggView2626569798028242279.v23 and production_year>2000;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin2074152798978467800;
