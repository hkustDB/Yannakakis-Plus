create or replace view aggView4231926491825790565 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin1410513273998257660 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView4231926491825790565 where mk.movie_id=aggView4231926491825790565.v23;
create or replace view aggView6444831763139283473 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin253495652619543595 as select v23, v37, v35 from aggJoin1410513273998257660 join aggView6444831763139283473 using(v8);
create or replace view aggView3208741977522667352 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin253495652619543595 group by v23;
create or replace view aggJoin6383610105350945379 as select person_id as v14, v37, v35 from cast_info as ci, aggView3208741977522667352 where ci.movie_id=aggView3208741977522667352.v23;
create or replace view aggView6989886236825196750 as select v14, MIN(v37) as v37, MIN(v35) as v35 from aggJoin6383610105350945379 group by v14;
create or replace view aggJoin2404994656395035693 as select name as v15, v37, v35 from name as n, aggView6989886236825196750 where n.id=aggView6989886236825196750.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin2404994656395035693;
