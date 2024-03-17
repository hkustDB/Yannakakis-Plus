create or replace view aggView7430339931478382041 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1237531851945447500 as select movie_id as v23, v36 from cast_info as ci, aggView7430339931478382041 where ci.person_id=aggView7430339931478382041.v14;
create or replace view aggView8447600108838556723 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin8562814295089456408 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView8447600108838556723 where mk.movie_id=aggView8447600108838556723.v23;
create or replace view aggView2734194347809907446 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin6205105034309009586 as select v23, v37 from aggJoin8562814295089456408 join aggView2734194347809907446 using(v8);
create or replace view aggView6831785199553604387 as select v23, MIN(v36) as v36 from aggJoin1237531851945447500 group by v23;
create or replace view aggJoin8210594915213754718 as select v37 as v37, v36 from aggJoin6205105034309009586 join aggView6831785199553604387 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8210594915213754718;
