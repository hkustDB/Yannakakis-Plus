create or replace view aggView8801120861150016566 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin2033184437596201152 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView8801120861150016566 where ci.movie_id=aggView8801120861150016566.v23;
create or replace view aggView5453720056097038241 as select id as v14, name as v36 from name as n;
create or replace view aggJoin1953628573552361448 as select v23, v37, v36 from aggJoin2033184437596201152 join aggView5453720056097038241 using(v14);
create or replace view aggView1843461771511726103 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1361912294563112791 as select movie_id as v23, v35 from movie_keyword as mk, aggView1843461771511726103 where mk.keyword_id=aggView1843461771511726103.v8;
create or replace view aggView5067455612467139495 as select v23, MIN(v35) as v35 from aggJoin1361912294563112791 group by v23,v35;
create or replace view aggJoin6031816377084534349 as select v37 as v37, v36 as v36, v35 from aggJoin1953628573552361448 join aggView5067455612467139495 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6031816377084534349;
