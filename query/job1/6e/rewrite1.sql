create or replace view aggView669307635303327821 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8978682284879563217 as select movie_id as v23, v36 from cast_info as ci, aggView669307635303327821 where ci.person_id=aggView669307635303327821.v14;
create or replace view aggView5009936657437794798 as select v23, MIN(v36) as v36 from aggJoin8978682284879563217 group by v23;
create or replace view aggJoin2832526387236261400 as select id as v23, title as v24, v36 from title as t, aggView5009936657437794798 where t.id=aggView5009936657437794798.v23 and production_year>2000;
create or replace view aggView621638971451649215 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin2832526387236261400 group by v23;
create or replace view aggJoin188743077080163793 as select keyword_id as v8, v36, v37 from movie_keyword as mk, aggView621638971451649215 where mk.movie_id=aggView621638971451649215.v23;
create or replace view aggView4080717054273857127 as select v8, MIN(v36) as v36, MIN(v37) as v37 from aggJoin188743077080163793 group by v8;
create or replace view aggJoin8540487718997297673 as select keyword as v9, v36, v37 from keyword as k, aggView4080717054273857127 where k.id=aggView4080717054273857127.v8 and keyword= 'marvel-cinematic-universe';
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8540487718997297673;
