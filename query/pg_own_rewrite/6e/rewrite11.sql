create or replace view aggView4562565661126423227 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin9212395489253395223 as select movie_id as v23, v35 from movie_keyword as mk, aggView4562565661126423227 where mk.keyword_id=aggView4562565661126423227.v8;
create or replace view aggView3595242268411790770 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4391363770532155334 as select movie_id as v23, v36 from cast_info as ci, aggView3595242268411790770 where ci.person_id=aggView3595242268411790770.v14;
create or replace view aggView8227215728435491757 as select v23, MIN(v35) as v35 from aggJoin9212395489253395223 group by v23,v35;
create or replace view aggJoin7970080236708878051 as select v23, v36 as v36, v35 from aggJoin4391363770532155334 join aggView8227215728435491757 using(v23);
create or replace view aggView6455720294973922001 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin3976922023219137293 as select v36, v35, v37 from aggJoin7970080236708878051 join aggView6455720294973922001 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3976922023219137293;
