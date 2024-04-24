create or replace view aggView6153068500615836725 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin104476028717379975 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView6153068500615836725 where mk.movie_id=aggView6153068500615836725.v23;
create or replace view aggView413289846068146064 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin8444279942918442053 as select v23, v37, v35 from aggJoin104476028717379975 join aggView413289846068146064 using(v8);
create or replace view aggView3581594322898917241 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin6028189596234736921 as select movie_id as v23, v36 from cast_info as ci, aggView3581594322898917241 where ci.person_id=aggView3581594322898917241.v14;
create or replace view aggView8034923403002154526 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin8444279942918442053 group by v23,v37,v35;
create or replace view aggJoin6751771072699587858 as select v36 as v36, v37, v35 from aggJoin6028189596234736921 join aggView8034923403002154526 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6751771072699587858;
