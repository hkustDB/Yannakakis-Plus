create or replace view aggView1360476465257728947 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin8849335989653518224 as select movie_id as v23, v35 from movie_keyword as mk, aggView1360476465257728947 where mk.keyword_id=aggView1360476465257728947.v8;
create or replace view aggView8670138279392020342 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin4976982023320286840 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView8670138279392020342 where ci.movie_id=aggView8670138279392020342.v23;
create or replace view aggView5208395056019259917 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2861865543239978377 as select v23, v37 from aggJoin4976982023320286840 join aggView5208395056019259917 using(v14);
create or replace view aggView346719213816933873 as select v23, MIN(v37) as v37 from aggJoin2861865543239978377 group by v23;
create or replace view aggJoin1954560423933572849 as select v35 as v35, v37 from aggJoin8849335989653518224 join aggView346719213816933873 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1954560423933572849;
