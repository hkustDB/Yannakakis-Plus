create or replace view aggView6102350181622547900 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3475219626630826837 as select movie_id as v23, v36 from cast_info as ci, aggView6102350181622547900 where ci.person_id=aggView6102350181622547900.v14;
create or replace view aggView682486887192664299 as select v23, MIN(v36) as v36 from aggJoin3475219626630826837 group by v23;
create or replace view aggJoin5989068730082223199 as select id as v23, title as v24, v36 from title as t, aggView682486887192664299 where t.id=aggView682486887192664299.v23 and production_year>2014;
create or replace view aggView9208162048327952779 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin5989068730082223199 group by v23;
create or replace view aggJoin4844551859140541139 as select keyword_id as v8, v36, v37 from movie_keyword as mk, aggView9208162048327952779 where mk.movie_id=aggView9208162048327952779.v23;
create or replace view aggView6498824306680044750 as select v8, MIN(v36) as v36, MIN(v37) as v37 from aggJoin4844551859140541139 group by v8;
create or replace view aggJoin5790307354547408538 as select keyword as v9, v36, v37 from keyword as k, aggView6498824306680044750 where k.id=aggView6498824306680044750.v8 and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5790307354547408538;
