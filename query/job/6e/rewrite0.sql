create or replace view aggView2236007154083320758 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin8924237014090812799 as select movie_id as v23, v35 from movie_keyword as mk, aggView2236007154083320758 where mk.keyword_id=aggView2236007154083320758.v8;
create or replace view aggView433547141868217037 as select v23, MIN(v35) as v35 from aggJoin8924237014090812799 group by v23;
create or replace view aggJoin9143583483805760428 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView433547141868217037 where t.id=aggView433547141868217037.v23 and production_year>2000;
create or replace view aggView77956004405906022 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin9143583483805760428 group by v23;
create or replace view aggJoin811056719873588148 as select person_id as v14, v35, v37 from cast_info as ci, aggView77956004405906022 where ci.movie_id=aggView77956004405906022.v23;
create or replace view aggView588657202762179487 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin811056719873588148 group by v14;
create or replace view aggJoin3166768404651175326 as select name as v15, v35, v37 from name as n, aggView588657202762179487 where n.id=aggView588657202762179487.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin3166768404651175326;
